import 'dart:convert';
import 'dart:core';
import 'dart:html';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:dio/dio.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/http/websocket_message.dart';
import 'package:localchat/models/common.dart' as common_model;
import 'package:localchat/models/common.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/state/messages_state.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:localchat/web/components/web_file_message.dart';
import 'package:localchat/web/components/web_text_message.dart';
import 'package:localchat/web/services/web_websocket_service.dart';
import 'package:localchat/web/web_common.dart' as common;
import 'package:pasteboard/pasteboard.dart';

class WebConversationMsgBox extends ConsumerStatefulWidget {
  const WebConversationMsgBox({super.key});

  @override
  ConsumerState<WebConversationMsgBox> createState() {
    return WebConversationMsgBoxState();
  }
}

class WebConversationMsgBoxState extends ConsumerState<WebConversationMsgBox> {
  late TextEditingController _inputController;
  late ScrollController _scrollController;
  late FocusNode _textFocusNode;
  late int textMaxLength;
  bool filePickerOpen = false;
  bool isEmojiShowing = false;
  bool isTextFiledClearButtonShowing = false;
  final _inputIconColor = const Color.fromARGB(255, 54, 48, 48);

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _inputController = TextEditingController();
    _scrollController = ScrollController();
    int windowsWidth = window.innerWidth ?? 350;
    textMaxLength = windowsWidth - 160;
    // _selectionController = TextSelectionControls();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _textFocusNode.dispose();
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var messages = ref.watch(messagesNotifierProvider);
    List<String> renderMessages;
    if (messages.isLoading) {
      renderMessages = [];
    } else {
      renderMessages = messages.value!;
    }
    return Expanded(
        child: SelectionArea(
      child: Column(
        children: [
          _buildMessageShowWidget(renderMessages),
          _buildMessageInputRow(context),
        ],
      ),
    ));
  }

  Widget _buildMessageShowWidget(List<String> renderMessages) {
    _scrollToBottom();
    // drag and drop widget
    return DropTarget(
        onDragDone: (detail) async {
          for (var file in detail.files) {
            var fileSize = await file.length();
            var fileStream = utils.openFileReadStream(file);
            common.logD('drag file result: ${file.name}, size: $fileSize');
            _sendFile(file.name, fileSize, fileStream);
          }
        },
        child: Expanded(
            child: ListView.builder(
          shrinkWrap: false,
          addAutomaticKeepAlives: true,
          padding: const EdgeInsets.all(10),
          controller: _scrollController,
          itemCount: renderMessages.length,
          itemBuilder: (context, index) {
            var msg = getMsg(renderMessages[index])!;
            return renderMessage(msg, isSelf: msg.senderID == common.selfId);
          },
        )));
  }

  Column _buildMessageInputRow(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                focusNode: _textFocusNode,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                controller: _inputController,
                onEditingComplete: () {
                  _sendMessage(context);
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '消息',
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _inputController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: onCancel,
                              color: _inputIconColor,
                            )
                          : const Text(""),
                      IconButton(
                          tooltip: '发送文件',
                          onPressed: () async {
                            if (filePickerOpen) {
                              return;
                            }
                            filePickerOpen = true;
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                    withData: false, withReadStream: true);
                            filePickerOpen = false;
                            if (result == null || result.files.isEmpty) {
                              return;
                            }
                            common.logD('filePicker result: $result');
                            var file = result.files.first;
                            _sendFile(file.name, file.size, file.readStream!);
                          },
                          color: _inputIconColor,
                          icon: const Icon(Icons.file_upload)),
                      IconButton(
                        icon: const Icon(Icons.emoji_emotions),
                        color: isEmojiShowing ? Colors.blue : _inputIconColor,
                        onPressed: emojiPickerButtonClickEvent,
                      ),
                    ],
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    isTextFiledClearButtonShowing = value.isNotEmpty;
                  });
                },
                onSubmitted: (value) => {
                  _sendMessage(context),
                  setState(() {
                    isTextFiledClearButtonShowing = false;
                  })
                },
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.send),
              onPressed: () {
                _sendMessage(context);
              },
              label: const Text('发送'),
            ),
          ],
        ),
        Offstage(
          offstage: !isEmojiShowing,
          child: SizedBox(
            height: 250,
            // width: 500,
            child: EmojiPicker(
                onEmojiSelected: (Category? category, Emoji emoji) {
                  // Do something when emoji is tapped (optional)
                  _inputController.text += emoji.emoji;
                },
                // Do something when the user taps the backspace button (optional)
                // Set it to null to hide the Backspace-Button
                onBackspacePressed: () {
                  _inputController
                    ..text =
                        _inputController.text.characters.skipLast(1).toString()
                    ..selection = TextSelection.fromPosition(
                        TextPosition(offset: _inputController.text.length));
                },
                config: Config(
                  columns: 7,
                  emojiSizeMax: 32 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.30
                          : 1.0),
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  initCategory: Category.RECENT,
                  bgColor: const Color(0xFFF2F2F2),
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  backspaceColor: Colors.blue,
                  skinToneDialogBgColor: Colors.white,
                  skinToneIndicatorColor: Colors.grey,
                  enableSkinTones: true,
                  recentTabBehavior: RecentTabBehavior.RECENT,
                  recentsLimit: 28,
                  noRecents: const Text(
                    'No Recents',
                    style: TextStyle(fontSize: 20, color: Colors.black26),
                    textAlign: TextAlign.center,
                  ), // Needs to be const Widget
                  loadingIndicator:
                      const SizedBox.shrink(), // Needs to be const Widget
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const CategoryIcons(),
                  buttonMode: ButtonMode.MATERIAL,
                )),
          ),
        ),
      ],
    );
  }

  _sendFile(String filename, int fileSize, Stream<List<int>> fileStream) async {
    var message = MessageModelData.file(filename,
        senderNickname: common.getUserModelData()!.nickName,
        senderPlatformID: common_model.Platform.web.value,
        senderID: common.getUserModelData()!.userId);
    var headerMap = {
      'token': '123456',
      'msg-id': message.msgId,
    };
    // add message to local
    ref.read(messagesNotifierProvider.notifier).add(message);
    Uri uri = Uri.parse('${common.address}/${utils.ossApiPath()}');
    try {
      if (fileSize > 1024 * 1024) {
        // segmented upload
        common.logI('$filename is ${(fileSize / 1024 / 1024).floor()}MB');
        headerMap['file-total-length'] = fileSize.toString();
        int i = -1;
        int sendLength = 0;
        await for (var data in fileStream) {
          sendLength += data.length;
          var progress = (sendLength * 100 / fileSize).ceilToDouble() / 100;
          MultipartFile multipartFile =
              MultipartFile.fromBytes(data, filename: filename);
          headerMap['file-segment-index'] = (i++).toString();
          common
              .logD('upload file $filename -- $i, progress ${progress * 100}%');
          if (!await _uploadMultipart(uri, multipartFile, headerMap)) {
            common.logE('upload file $filename -- $i failed');
            return;
          }
          ref
              .read(messageSendProgressNotifierProvider.notifier)
              .add(message.msgId!, progress);
        }
        // all parts have benn uploaded success
        _sendFileWebsocketMessage(message, filename);
        ref
            .read(messageSendProgressNotifierProvider.notifier)
            .delete(message.msgId!);
      } else {
        // upload
        MultipartFile multipartFile = MultipartFile.fromStream(
            () => fileStream!, fileSize,
            filename: filename);
        common.logD('upload file $filename');
        if (await _uploadMultipart(uri, multipartFile, headerMap)) {
          _sendFileWebsocketMessage(message, filename);
        }
      }
    } catch (e) {
      common.logE('send file failed, error is $e');
    }
  }

  //
  _sendFileWebsocketMessage(MessageModelData message, String filename) {
    message.content =
        utf8.encode('${utils.ossApiPath()}/${message.msgId!}/$filename');
    WebWsService().send(WebsocketMessage.sendMessage(message));
    common.logI('upload file $filename success');
  }

  Future<bool> _uploadMultipart(Uri uri, MultipartFile multipartFile,
      Map<String, String?> headerMap) async {
    FormData formData = FormData.fromMap({
      "file": multipartFile,
    });
    var response = await common.dio
        .postUri(uri, data: formData, options: Options(headers: headerMap));
    if (response.statusCode == 200) {
      return true;
    } else {
      common.logE('upload file failed, response: ${response.data}');
      return false;
    }
  }

  _sendMessage(BuildContext context) async {
    testReadClipboard(context);
    var msg = _inputController.value.text;
    if (msg.trim().isEmpty) {
      return;
    }
    try {
      var message = MessageModelData.text(msg,
          senderNickname: common.getUserModelData()!.nickName,
          senderPlatformID: 1,
          senderID: common.getUserModelData()!.userId);
      ref.read(messagesNotifierProvider.notifier).add(message);
      WebWsService().send(WebsocketMessage.sendMessage(message));
    } catch (e, s) {
      common.logE('sendTextMessage failed, error: $e, stackTrace: $s');
    } finally {
      _inputController.clear();
      _textFocusNode.requestFocus();
      _scrollToBottom();
    }
  }

  onCancel() {
    _inputController.clear();
    setState(() {
      isTextFiledClearButtonShowing = false;
    });
  }

  emojiPickerButtonClickEvent() {
    setState(() {
      isEmojiShowing = !isEmojiShowing;
    });
  }

  _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  // 渲染消息， 用于抽象不同消息类型的展示
  Widget renderMessage(MessageModelData msg, {bool isSelf = false}) {
    switch (ContentType.values[msg.contentType!]) {
      case ContentType.text:
        var contentStr = utf8.decode(msg.content!);
        return WebTextMessage(
            senderName: msg.senderNickname!,
            content: contentStr,
            isSelf: isSelf,
            maxLength: textMaxLength.toDouble());
      case ContentType.file:
        return WebFileMessage(msg: msg, isSelf: isSelf);
      default:
        return const Row(children: [
          Text(
            "unknown message",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ]);
    }
  }

  /// RenderText is used to render message
  ///
  /// if isSelf is true, the message will be rendered on the right side,
  /// otherwise on the left side
  Row _renderTextMsg(String name, String content, {bool isSelf = false}) {
    String fellowAvtar = 'assets/images/avatarMan.jpg';
    var align = isSelf ? MainAxisAlignment.end : MainAxisAlignment.start;
    var senderAvatar = Container(
      margin: const EdgeInsets.all(5),
      child: Image(
          width: 50,
          height: 50,
          image:
              AssetImage(isSelf ? 'assets/images/avatarMan.jpg' : fellowAvtar)),
    );
    var copyButton = Container(
      constraints: const BoxConstraints(maxWidth: 30),
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: IconButton(
        icon: const Icon(Icons.copy),
        tooltip: '复制',
        onPressed: () {
          Clipboard.setData(ClipboardData(text: content)).then((_) {
            utils.showSnackBar(
                context,
                const Center(
                    child: Text(
                  "已复制聊天内容",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )));
          });
        },
      ),
    );
    Color messageBackgroundColor;
    if (Theme.of(context).brightness == Brightness.dark) {
      messageBackgroundColor = Colors.white24;
    } else {
      messageBackgroundColor = Colors.lightGreenAccent;
    }
    var messageText = Container(
      constraints: BoxConstraints(maxWidth: textMaxLength.toDouble()),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: messageBackgroundColor),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        shadows: [
          BoxShadow(
            color: messageBackgroundColor,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Text(
        ' $content ',
        softWrap: true,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
    return Row(
      mainAxisAlignment: align,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: isSelf
          ? [copyButton, messageText, senderAvatar]
          : [senderAvatar, messageText, copyButton],
    );
  }

  // 测试是否有复制图片
  testReadClipboard(BuildContext context) async {
    var data = await Pasteboard.image;
    if (data == null) {
      return;
    }
    var b0 = data[0].toRadixString(16);
    var b1 = data[1].toRadixString(16);
    var b2 = data[2].toRadixString(16);
    if (b0 == "42" && b1 == "4d") {
      common.logI("bmp");
    } else if (b0 == "ff" && b1 == "d8") {
      common.logI("jpg");
    } else if (b0 == "89" && b1 == "50" && b2 == "4e") {
      common.logI("png");
    }
    if (context.mounted) {
      showDialog<bool>(
          context: context,
          builder: (context) {
            return Dialog(
              alignment: Alignment.bottomRight,
              // insetPadding:
              // EdgeInsets.only(left: localOffset.dx, top: localOffset.dy),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 10),
                    Image.memory(
                      data,
                      width: 500,
                      height: 500,
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }
}
