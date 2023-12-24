// SessionMessageBox 是消息展示区域
import 'dart:convert';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emoji_picker;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/config.dart';
import 'package:localchat/http/websocket_service.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/models/common.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/oss/oss_service.dart';
import 'package:localchat/pages/chat/FileMessage.dart';
import 'package:localchat/state/messages_state.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:pasteboard/pasteboard.dart';

class ConversationMessageBox extends ConsumerStatefulWidget {
  const ConversationMessageBox({super.key});

  @override
  ConsumerState<ConversationMessageBox> createState() {
    return ConversationMessageBoxState();
  }
}

class ConversationMessageBoxState
    extends ConsumerState<ConversationMessageBox> {
  late TextEditingController _inputController;
  late ScrollController _scrollController;
  late FocusNode _textFocusNode;
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
        child: SelectionArea(
      child: Column(
        children: [
          _buildMessageShowWidget(renderMessages, context),
          _buildMessageInputRow(context),
        ],
      ),
    ));
  }

  Widget _buildMessageShowWidget(
      List<String> renderMessages, BuildContext context) {
    _scrollToBottom();
    return Expanded(
        child: ListView.builder(
      padding: const EdgeInsets.all(10),
      controller: _scrollController,
      itemCount: renderMessages.length,
      itemBuilder: (context, index) {
        return renderMessage(getMsg(renderMessages[index])!, context);
      },
    ));
  }

  Column _buildMessageInputRow(BuildContext context) {
    return Column(
      children: [
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
                onEditingComplete: _sendTextMessage,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '消息',
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _inputController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _onCancel,
                            )
                          : const Text(""),
                      IconButton(
                          tooltip: '发送图片',
                          onPressed: () async {
                            if (filePickerOpen) {
                              return;
                            }
                            filePickerOpen = true;
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            filePickerOpen = false;
                            if (result != null) {
                              logger.i(
                                  'prepare to send file ${result.files.single.path}');
                              _sendFile(result.files.single.path!);
                            }
                          },
                          color: _inputIconColor,
                          icon: const Icon(Icons.file_upload)),
                      IconButton(
                        icon: const Icon(Icons.emoji_emotions),
                        color: isEmojiShowing
                            ? Colors.blue
                            : const Color.fromARGB(255, 54, 48, 48),
                        onPressed: _emojiPickerButtonClickEvent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.send),
              onPressed: _sendTextMessage,
              label: const Text('发送'),
            ),
          ],
        ),
        Offstage(
          offstage: !isEmojiShowing,
          child: SizedBox(
            height: 250,
            // width: 500,
            child: emoji_picker.EmojiPicker(
                onEmojiSelected: (emoji_picker.Category? category,
                    emoji_picker.Emoji emoji) {
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
                config: emoji_picker.Config(
                  columns: 7,
                  emojiSizeMax: 32 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.30
                          : 1.0),
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  initCategory: emoji_picker.Category.RECENT,
                  bgColor: const Color(0xFFF2F2F2),
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  backspaceColor: Colors.blue,
                  skinToneDialogBgColor: Colors.white,
                  skinToneIndicatorColor: Colors.grey,
                  enableSkinTones: true,
                  recentTabBehavior: emoji_picker.RecentTabBehavior.RECENT,
                  recentsLimit: 28,
                  noRecents: const Text(
                    'No Recents',
                    style: TextStyle(fontSize: 20, color: Colors.black26),
                    textAlign: TextAlign.center,
                  ), // Needs to be const Widget
                  loadingIndicator:
                      const SizedBox.shrink(), // Needs to be const Widget
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const emoji_picker.CategoryIcons(),
                  buttonMode: emoji_picker.ButtonMode.MATERIAL,
                )),
          ),
        ),
      ],
    );
  }

  _sendFile(String fileFullPath) {
    var message = MessageModelData.file('',
        senderNickname: "主持人", senderPlatformID: 1, senderID: Config().selfId);
    var fileDownloadPath = OssService().upload(message.msgId!, fileFullPath);
    message.content = utf8.encode(fileDownloadPath);
    _sendWebsocketMessage(message);
  }

  _sendTextMessage() {
    var msg = _inputController.value.text;
    if (msg.trim().isEmpty) {
      return;
    }
    var message = MessageModelData.text(msg,
        senderNickname: "主持人", senderPlatformID: 1, senderID: Config().selfId);
    _sendWebsocketMessage(message);
  }

  _sendWebsocketMessage(MessageModelData message) async {
    try {
      WebSocketService().sendMessage(message);
      ref.read(messagesNotifierProvider.notifier).add(message);
    } catch (e, s) {
      logger.e('_sendWebsocketMessage failed', error: e, stackTrace: s);
    } finally {
      if (message.contentType == ContentType.text.value) {
        _inputController.clear();
        _textFocusNode.requestFocus();
      }
      _scrollToBottom();
    }
  }

  _onCancel() {
    _inputController.clear();
    setState(() {
      isTextFiledClearButtonShowing = false;
    });
  }

  _emojiPickerButtonClickEvent() {
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
  Widget renderMessage(MessageModelData msg, BuildContext context) {
    var isSelf = msg.senderID == Config().selfId;
    switch (ContentType.values[msg.contentType!]) {
      case ContentType.text:
        var contentStr = utf8.decode(msg.content!);
        return _renderTextMsg(
          msg.senderNickname!,
          contentStr,
          context,
          isSelf: isSelf,
        );
      // case ContentType.image:
      //   break;
      case ContentType.file:
        return _renderFileMsg(msg, isSelf: isSelf);
      default:
        return const Row(children: [
          Text("unknown message"),
        ]);
    }
  }

  FileMessage _renderFileMsg(MessageModelData msgModel, {bool isSelf = false}) {
    return FileMessage(msg: msgModel, isSelf: isSelf);
  }

  /// RenderText is used to render message
  ///
  /// if isSelf is true, the message will be rendered on the right side,
  /// otherwise on the left side
  Row _renderTextMsg(String name, String content, BuildContext context,
      {bool isSelf = false}) {
    String fellowAvtar = 'assets/images/avatarMan.jpg';
    var align = isSelf ? MainAxisAlignment.end : MainAxisAlignment.start;
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
        text: isSelf ? '  $name    ' : '$name  ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ]));
    var copyButton = Container(
      constraints: const BoxConstraints(maxWidth: 600),
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
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                )));
          });
        },
      ),
    );
    const messageBackgroundColor = Colors.white12;
    var messageText = Container(
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: messageBackgroundColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        shadows: [
          BoxShadow(
            color: messageBackgroundColor,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Text(
        '  $content  ',
        style: const TextStyle(fontSize: 20),
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
    if (data != null) {
      var b0 = data[0].toRadixString(16);
      var b1 = data[1].toRadixString(16);
      var b2 = data[2].toRadixString(16);
      if (b0 == "42" && b1 == "4d") {
        logger.i("bmp");
      } else if (b0 == "ff" && b1 == "d8") {
        logger.i("jpg");
      } else if (b0 == "89" && b1 == "50" && b2 == "4e") {
        logger.i("png");
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
      if (data != null) {
        logger.i(data);
      }
    }
  }
}
