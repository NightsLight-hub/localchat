// SessionMessageBox 是消息展示区域
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/config.dart';
import 'package:localchat/http/router.dart' as router;
import 'package:localchat/http/websocket_service.dart';
import 'package:localchat/http_utils.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/models/common.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/state/messages_state.dart';
import 'package:open_file/open_file.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:path/path.dart' as p;

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
      padding: const EdgeInsets.all(10),
      controller: _scrollController,
      itemCount: renderMessages.length,
      itemBuilder: (context, index) {
        if (renderMessages[index].senderID != Config().selfId) {
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
            FloatingActionButton.small(
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
                    logger
                        .i('prepare to send file ${result.files.single.path}');
                    _sendFile(result.files.single.path!);
                  }
                },
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
                onEditingComplete: _sendTextMessage,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '消息',
                ),
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.send),
              onPressed: _sendTextMessage,
              label: const Text('发送'),
            ),
          ],
        )
      ],
    );
  }

  _sendFile(String fileFullPath) {
    var splitPoint = fileFullPath.lastIndexOf('\\');
    p.dirname(fileFullPath);
    // var directory = fileFullPath.substring(0, splitPoint);
    var directory = p.dirname(fileFullPath);
    // var fileName = fileFullPath.substring(splitPoint + 1);
    var fileName = p.basename(fileFullPath);
    var fileDownloadPath = router.addDownloadMount(directory, fileName);
    var message = MessageModelData.file(fileDownloadPath,
        senderNickname: "主持人", senderPlatformID: 1, senderID: Config().selfId);
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

  Row _renderFileMsg(MessageModelData msg, {bool isSelf = false}) {
    var filePath = utf8.decode(msg.content!);
    var fileUrl = '${Config().address}$filePath';
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
        color: const Color(0xFF95EC69),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(width: 8, color: Colors.white),
      ),
      child: FloatingActionButton.extended(
          icon: const Icon(Icons.file_open),
          tooltip: '文件路径: $fileUrl',
          onPressed: () {
            var cachePath = utils.getDownloadPath(filename: fileName);
            if (File(cachePath).existsSync()) {
              OpenFile.open(cachePath);
              return;
            }
            try {
              HttpUtil.download(fileUrl, savePath: cachePath).then((value) {
                logger.i('download file $fileUrl to $cachePath success');
              });
            } catch (e) {
              logger.e('download file $fileUrl to $cachePath failed', error: e);
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

  /// RenderText is used to render message
  ///
  /// if isSelf is true, the message will be rendered on the right side,
  /// otherwise on the left side
  Row _renderTextMsg(String name, String content, {bool isSelf = false}) {
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
