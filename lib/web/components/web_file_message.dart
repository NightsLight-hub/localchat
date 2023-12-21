import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/state/messages_state.dart';
import 'package:localchat/web/web_common.dart' as common;
import 'package:path/path.dart' as p;

class WebFileMessage extends ConsumerStatefulWidget {
  const WebFileMessage({
    Key? key,
    required this.msg,
    required this.isSelf,
  }) : super(key: key);

  final MessageModelData msg;
  final bool isSelf;

  // final String Function(String fileUrl, String fileName) onPressed;

  @override
  WebFileMessageState createState() => WebFileMessageState();
}

class WebFileMessageState extends ConsumerState<WebFileMessage> {
  String fileUrl = '';
  String fileName = '';
  String filePath = '';
  MainAxisAlignment align = MainAxisAlignment.start;

  @override
  void initState() {
    super.initState();
    filePath = utf8.decode(widget.msg.content!);
    if (filePath.startsWith('/')) {
      filePath.substring(1);
    }
    fileUrl = '${common.address}/$filePath';
    fileName = p.basename(filePath);
    align = widget.isSelf ? MainAxisAlignment.end : MainAxisAlignment.start;
  }

  @override
  Widget build(BuildContext context) {
    var messageProgressNotifier =
        ref.watch(messageSendProgressNotifierProvider);
    Map<String, double?> msgProgressMap = {};
    if (!messageProgressNotifier.isLoading) {
      msgProgressMap = messageProgressNotifier.value!;
    }
    var senderAvatar = Container(
      margin: const EdgeInsets.all(10),
      child: Image(
          width: 50,
          height: 50,
          image: AssetImage(widget.isSelf
              ? 'assets/images/avatarMan.jpg'
              : 'assets/images/avatarMan.jpg')),
    );
    ProgressIndicator? progressIndicator;
    if (msgProgressMap[widget.msg.msgId] != null) {
      progressIndicator = CircularProgressIndicator(
        backgroundColor: Colors.grey[200],
        valueColor: const AlwaysStoppedAnimation(Colors.red),
        strokeWidth: 1,
        value: msgProgressMap[widget.msg.msgId],
      );
    }

    var messageText = Container(
        margin: const EdgeInsets.all(5.0),
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: const BoxDecoration(
          // color: widget.isSelf ? const Color(0xFF95EC69) : null,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          // border: Border.all(width: 8, color: Colors.white),
        ),
        child: Column(
          children: [
            FloatingActionButton.extended(
                icon: progressIndicator ?? const Icon(Icons.file_open),
                tooltip: _tooltip(),
                onPressed: () {
                  try {
                    _downloadFile(fileUrl, fileName);
                  } catch (e) {
                    common.logE('download file $fileUrl failed, error: e');
                  }
                },
                label: Text(fileName)),
          ],
        ));
    return Row(
      mainAxisAlignment: align,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.isSelf
          ? [
              // if (progressIndicator != null) progressIndicator,
              messageText,
              senderAvatar
            ]
          : [
              senderAvatar,
              messageText,
              // if (progressIndicator != null) progressIndicator,
            ],
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

  _tooltip() {
    return '文件下载路径: $fileUrl';
  }
}
