import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/http/websocket_message.dart';
import 'package:localchat/models/common.dart';
import 'package:localchat/models/common.dart' as common_model;
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/state/messages_state.dart';
import 'package:localchat/web/services/web_websocket_service.dart';
import 'package:localchat/web/web_common.dart' as common;
import 'package:pasteboard/pasteboard.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:path/path.dart' as p;

class WebConversationMsgBox extends ConsumerStatefulWidget {
  const WebConversationMsgBox({Key? key}) : super(key: key);

  @override
  ConsumerState<WebConversationMsgBox> createState() {
    return WebConversationMsgBoxState();
  }
}

class WebConversationMsgBoxState extends ConsumerState<WebConversationMsgBox> {
  late TextEditingController _inputController;
  late ScrollController _scrollController;
  late FocusNode _textFocusNode;
  bool filePickerOpen = false;
  bool isEmojiShowing = false;
  bool isTextFiledClearButtonShowing = false;

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _inputController = TextEditingController();
    _scrollController = ScrollController();
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
    // if (renderMessages.length > Config().defaultMessageShowNumber) {
    //   renderMessages =
    //       messages.sublist(messages.length - Config().defaultMessageShowNumber);
    // } else {
    //   renderMessages = messages;
    // }
    return Expanded(
      child: Column(
        children: [
          _buildMessageShowWidget(renderMessages),
          _buildMessageInputRow(context),
        ],
      ),
    );
  }

  Widget _buildMessageShowWidget(List<String> renderMessages) {
    _scrollToBottom();
    return Expanded(
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
    ));
  }

  Column _buildMessageInputRow(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            FloatingActionButton.small(
                tooltip: '发送图片',
                onPressed: _sendFile,
                child: const Icon(Icons.file_upload)),
          ],
        ),
        const SizedBox(height: 10),
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
                            )
                          : const Text(""),
                      IconButton(
                        icon: const Icon(Icons.emoji_emotions),
                        color: isEmojiShowing
                            ? Colors.blue
                            : const Color.fromARGB(255, 54, 48, 48),
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

  _sendFile() async {
    if (filePickerOpen) {
      return;
    }
    filePickerOpen = true;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(withData: false, withReadStream: true);
    filePickerOpen = false;
    if (result != null && result.files.isNotEmpty) {
      common.logD('filePicker result: $result');
      var file = result.files.first;
      var message = MessageModelData.file(file.name,
          senderNickname: common.getUserModelData()!.nickName,
          senderPlatformID: common_model.Platform.web.value,
          senderID: common.getUserModelData()!.userId);
      // add message to local
      ref.read(messagesNotifierProvider.notifier).add(message);
      try {
        // start upload
        MultipartFile multipartFile = MultipartFile.fromStream(
            () => file.readStream!, file.size,
            filename: file.name);
        FormData formData = FormData.fromMap({
          "file": multipartFile,
        });
        Uri uri = Uri.parse('${common.address}/${utils.ossApiPath()}');
        common.logI('uploadFile to $uri');
        var headerMap = {
          'token': '123456',
          'msgId': message.msgId,
        };
        // upload file to oss
        common.logD('upload file ${file.name}');
        var response = await common.dio
            .postUri(uri, data: formData, options: Options(headers: headerMap));
        if (response.statusCode == 200) {
          // get fileUrl and modify message and send it to server
          print(response.data);
          String msgId = response.data['message'];
          message.content =
              utf8.encode('${utils.ossApiPath()}/$msgId/${file.name}');
          WebWsService().send(WebsocketMessage.sendMessage(message));
          common.logI('upload file success');
        } else {
          common.logE('upload file failed, response: ${response.data}');
        }
      } catch (e) {
        common.logE('send file failed, error is $e');
      }
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
  Row renderMessage(MessageModelData msg, {bool isSelf = false}) {
    switch (ContentType.values[msg.contentType!]) {
      case ContentType.text:
        var contentStr = utf8.decode(msg.content!);
        return _renderTextMsg(msg.senderNickname!, contentStr, isSelf: isSelf);
      case ContentType.file:
        return _renderFileMsg(msg, isSelf: isSelf);
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

  Row _renderFileMsg(MessageModelData msg, {bool isSelf = false}) {
    var filePath = utf8.decode(msg.content!);
    if (filePath.startsWith('/')) {
      filePath.substring(1);
    }
    var fileUrl = '${common.address}/$filePath';
    var fileName = p.basename(filePath);
    var align = isSelf ? MainAxisAlignment.end : MainAxisAlignment.start;
    var senderAvatar = Container(
      margin: const EdgeInsets.all(10),
      child: Image(
          width: 50,
          height: 50,
          image: AssetImage(isSelf
              ? 'assets/images/avatarMan.jpg'
              : 'assets/images/avatarMan.jpg')),
    );
    var messageText = Container(
      margin: const EdgeInsets.all(5.0),
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        color: isSelf ? const Color(0xFF95EC69) : null,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(width: 8, color: Colors.white),
      ),
      child: FloatingActionButton.extended(
          icon: const Icon(Icons.file_open),
          tooltip: '文件路径: $fileUrl',
          onPressed: () {
            try {
              _downloadFile(fileUrl, fileName);
            } catch (e) {
              common.logE('download file $fileUrl failed, error: e');
            }
          },
          label: Text(fileName)),
    );
    return Row(
      mainAxisAlignment: align,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          isSelf ? [messageText, senderAvatar] : [senderAvatar, messageText],
    );
  }

  _downloadFile(String fileUrl, fileName) {
    HtmlDocument htmlDocument = document;
    AnchorElement anchor = htmlDocument.createElement('a') as AnchorElement;
    anchor.href = fileUrl;
    anchor.style.display = fileName;
    anchor.download = fileName;
    document.body!.children.add(anchor);
    anchor.click();
    document.body!.children.remove(anchor);
  }

  /// RenderText is used to render message
  ///
  /// if isSelf is true, the message will be rendered on the right side,
  /// otherwise on the left side
  Row _renderTextMsg(String name, String content, {bool isSelf = false}) {
    String fellowAvtar = 'assets/images/avatarMan.jpg';
    var align = isSelf ? MainAxisAlignment.start : MainAxisAlignment.end;
    var senderAvatar = Container(
      margin: const EdgeInsets.all(10),
      child: Image(
          width: 50,
          height: 50,
          image:
              AssetImage(isSelf ? 'assets/images/avatarMan.jpg' : fellowAvtar)),
    );
    var senderName = Text.rich(TextSpan(children: [
      TextSpan(
        text: isSelf ? '  $name' : '$name  ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ]));
    var messageText = Container(
        margin: const EdgeInsets.all(5.0),
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          color: isSelf ? const Color(0xFF95EC69) : null,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 8, color: Colors.white),
        ),
        child: SelectionArea(
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ));
    return Row(
      mainAxisAlignment: align,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          isSelf ? [messageText, senderAvatar] : [senderAvatar, messageText],
    );
  }

  // 测试是否有复制图片
  testReadClipboard(BuildContext context) async {
    var data = await Pasteboard.image;
    if (data != null) {
      var b0 = data[0].toRadixString(16);
      var b1 = data[1].toRadixString(16);
      var b2 = data[2].toRadixString(16);
      if (b0 == "42" && b1 == "4d") {
        print("bmp");
      } else if (b0 == "ff" && b1 == "d8") {
        print("jpg");
      } else if (b0 == "89" && b1 == "50" && b2 == "4e") {
        print("png");
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
    } else {
      var data = await Pasteboard.files();
      print(data);
    }
  }
}
