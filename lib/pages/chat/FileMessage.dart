import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:path/path.dart' as p;

class FileMessage extends ConsumerStatefulWidget {
  FileMessage({
    Key? key,
    required this.msg,
    required this.isSelf,
    required this.serverAddress,
    required this.onPressed,
  }) : super(key: key);

  final MessageModelData msg;
  final bool isSelf;
  final String serverAddress;
  final String Function(String fileUrl, String fileName) onPressed;

  @override
  FileMessageState createState() => FileMessageState();
}

class FileMessageState extends ConsumerState<FileMessage> {
  String fileUrl = '';
  String fileName = '';
  MainAxisAlignment align = MainAxisAlignment.start;
  String cachePath = '';

  @override
  void initState() {
    super.initState();
    var filePath = utf8.decode(widget.msg.content!);
    if (!filePath.startsWith('/')) {
      filePath = '/$filePath';
    }
    fileUrl = '${widget.serverAddress}$filePath';
    fileName = p.basename(filePath);
    align = widget.isSelf ? MainAxisAlignment.end : MainAxisAlignment.start;
  }

  @override
  Widget build(BuildContext context) {
    var senderAvatar = Container(
      margin: const EdgeInsets.all(10),
      child: Image(
          width: 50,
          height: 50,
          image: AssetImage(widget.isSelf
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
          icon: widget.msg.downloaded
              ? const Icon(Icons.file_download_done)
              : const Icon(Icons.file_download),
          tooltip: _tooltip(),
          onPressed: () {
            var cp = widget.onPressed(fileUrl, fileName);
            setState(() {
              widget.msg.downloaded = true;
              cachePath = cp;
            });
          },
          label: Text(fileName)),
    );
    return Row(
      mainAxisAlignment: align,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.isSelf
          ? [messageText, senderAvatar]
          : [senderAvatar, messageText],
    );
  }

  _tooltip() {
    if (widget.msg.downloaded) {
      return '文件下载路径: $fileUrl\n缓存路径: $cachePath';
    } else {
      return '文件下载路径: $fileUrl';
    }
  }
}
