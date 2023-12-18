// SessionMessageBox 是消息展示区域
import 'dart:convert';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emojiPicker;
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
import 'package:localchat/pages/chat/FileMessage.dart';
import 'package:localchat/state/messages_state.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:open_file/open_file.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart' as foundation;

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
      padding: const EdgeInsets.all(10),
      controller: _scrollController,
      itemCount: renderMessages.length,
      itemBuilder: (context, index) {
        return renderMessage(getMsg(renderMessages[index])!);
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
            child: emojiPicker.EmojiPicker(
                onEmojiSelected:
                    (emojiPicker.Category? category, emojiPicker.Emoji emoji) {
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
                config: emojiPicker.Config(
                  columns: 7,
                  emojiSizeMax: 32 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.30
                          : 1.0),
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  initCategory: emojiPicker.Category.RECENT,
                  bgColor: const Color(0xFFF2F2F2),
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  backspaceColor: Colors.blue,
                  skinToneDialogBgColor: Colors.white,
                  skinToneIndicatorColor: Colors.grey,
                  enableSkinTones: true,
                  recentTabBehavior: emojiPicker.RecentTabBehavior.RECENT,
                  recentsLimit: 28,
                  noRecents: const Text(
                    'No Recents',
                    style: TextStyle(fontSize: 20, color: Colors.black26),
                    textAlign: TextAlign.center,
                  ), // Needs to be const Widget
                  loadingIndicator:
                      const SizedBox.shrink(), // Needs to be const Widget
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const emojiPicker.CategoryIcons(),
                  buttonMode: emojiPicker.ButtonMode.MATERIAL,
                )),
          ),
        ),
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
  Widget renderMessage(MessageModelData msg) {
    var isSelf = msg.senderID == Config().selfId;
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

  FileMessage _renderFileMsg(MessageModelData msgModel, {bool isSelf = false}) {
    return FileMessage(
        msg: msgModel,
        isSelf: isSelf,
        serverAddress: Config().address,
        onPressed: (fileUrl, fileName) {
          var cachePath = utils.getDownloadPath(filename: fileName);
          var file = File(cachePath);
          var exist = file.existsSync();
          if (msgModel.downloaded && exist) {
            // downloaded is true, and file exists, then we can open it.
            // it should be removed and downloaded again
            OpenFile.open(cachePath);
            return cachePath;
          }
          // if file not exists, we should download it, try to remove it at first.
          // if downloaded = false, but the file is existed, then the fileMessage may
          // have be sent multiple times, we should remove it and download again.
          if (exist) {
            file.deleteSync();
          }
          try {
            HttpUtil.download(fileUrl, savePath: cachePath).then((value) {
              logger.i('download file $fileUrl to $cachePath success');
              msgModel.downloaded = true;
              ref.read(messagesNotifierProvider.notifier).add(msgModel);
            });
            return cachePath;
          } catch (e) {
            logger.e('download file $fileUrl to $cachePath failed', error: e);
            return '';
          }
        });
  }

  // Row _renderFileMsg(MessageModelData msg, {bool isSelf = false}) {
  //   var filePath = utf8.decode(msg.content!);
  //   var fileUrl = '${Config().address}$filePath';
  //   var fileName = p.basename(filePath);
  //   var align = isSelf ? MainAxisAlignment.end : MainAxisAlignment.start;
  //   var senderAvatar = Container(
  //     margin: const EdgeInsets.all(10),
  //     child: Image(
  //         width: 50,
  //         height: 50,
  //         image: AssetImage(isSelf
  //             ? 'assets/images/avatarMan.jpg'
  //             : 'assets/images/avatarMan.jpg')),
  //   );
  //   var messageText = Container(
  //     margin: const EdgeInsets.all(5.0),
  //     constraints: const BoxConstraints(maxWidth: 600),
  //     decoration: BoxDecoration(
  //       color: const Color(0xFF95EC69),
  //       borderRadius: const BorderRadius.all(Radius.circular(4.0)),
  //       border: Border.all(width: 8, color: Colors.white),
  //     ),
  //     child: FloatingActionButton.extended(
  //         icon: msg.downloaded
  //             ? const Icon(Icons.file_download_done)
  //             : const Icon(Icons.file_download),
  //         tooltip: '文件路径: $fileUrl',
  //         onPressed: () {
  //           var cachePath = utils.getDownloadPath(filename: fileName);
  //           var file = File(cachePath);
  //           var exist = file.existsSync();
  //           if (msg.downloaded && exist) {
  //             // downloaded is true, and file exists, then we can open it.
  //             // it should be removed and downloaded again
  //             OpenFile.open(cachePath);
  //             return;
  //           }
  //           // if file not exists, we should download it, try to remove it at first.
  //           // if downloaded = false, but the file is existed, then the fileMessage may
  //           // have be sent multiple times, we should remove it and download again.
  //           if (exist) {
  //             file.deleteSync();
  //           }
  //           try {
  //             HttpUtil.download(fileUrl, savePath: cachePath).then((value) {
  //               logger.i('download file $fileUrl to $cachePath success');
  //               msg.downloaded = true;
  //               ref.read(messagesNotifierProvider.notifier).add(msg);
  //             });
  //           } catch (e) {
  //             logger.e('download file $fileUrl to $cachePath failed', error: e);
  //           }
  //         },
  //         label: Text(fileName)),
  //   );
  //   return Row(
  //     mainAxisAlignment: align,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children:
  //         isSelf ? [messageText, senderAvatar] : [senderAvatar, messageText],
  //   );
  // }

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
