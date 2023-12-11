import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/http/websocket_message.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/models/common.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/state/messages_state.dart';
import 'package:localchat/web/services/web_websocket_service.dart';
import 'package:localchat/web/web_common.dart' as common;
import 'package:pasteboard/pasteboard.dart';

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
    List<MessageModelData> renderMessages;
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

  Widget _buildMessageShowWidget(List<MessageModelData> renderMessages) {
    _scrollToBottom();
    return Expanded(
        child: ListView.builder(
      addAutomaticKeepAlives: true,
      padding: const EdgeInsets.all(10),
      controller: _scrollController,
      itemCount: renderMessages.length,
      itemBuilder: (context, index) {
        if (renderMessages[index].senderID != "self") {
          return renderMessage(renderMessages[index]);
        } else {
          return renderMessage(renderMessages[index], isSelf: true);
        }
      },
    ));
  }

  Column _buildMessageInputRow(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.file_upload),
                label: const Text('上传图片')),
          ],
        ),
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '消息',
                ),
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
        )
      ],
    );
  }

  _sendMessage(BuildContext context) async {
    testReadClipboard(context);
    var msg = _inputController.value.text;
    if (msg.trim().isEmpty) {
      return;
    }
    try {
      var message = MessageModelData.text(msg,
          senderNickname: "主持人",
          senderPlatformID: 1,
          senderID: common.getUserModelData()!.userId);
      ref.read(messagesNotifierProvider.notifier).add(message);
      WebWsService().sendMessage(WebsocketMessage.sendMessage(message));
    } catch (e, s) {
      logger.e('sendTextMessage failed', error: e, stackTrace: s);
    } finally {
      _inputController.clear();
      _textFocusNode.requestFocus();
      _scrollToBottom();
    }
  }

  _scrollToBottom() {
    // Future.delayed(const Duration(milliseconds: 50), () {
    //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // });
  }

  // 渲染消息， 用于抽象不同消息类型的展示
  Row renderMessage(MessageModelData msg, {bool isSelf = false}) {
    if (msg.contentType == ContentType.text.value) {
      var contentStr = utf8.decode(msg.content!);
      return _renderText(msg.senderNickname!, contentStr, isSelf: isSelf);
    } else {
      return const Row(children: [
        Text("unknown message"),
      ]);
    }
  }

  /// RenderText is used to render message
  ///
  /// if isSelf is true, the message will be rendered on the right side,
  /// otherwise on the left side
  Row _renderText(String name, String content, {bool isSelf = false}) {
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
    var messageText = Container(
        margin: const EdgeInsets.all(5.0),
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          color: const Color(0xFF95EC69),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 8, color: Colors.white),
        ),
        child: SelectionArea(
          child: Text(
            content,
            // style: GoogleFonts.lato(
            //     textStyle: const TextStyle(
            //   color: Colors.black,
            //   fontSize: 18,
            // )),
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
