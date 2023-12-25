import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/oss/oss_service.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;

class FileMessage extends ConsumerStatefulWidget {
  const FileMessage({
    Key? key,
    required this.msg,
    required this.isSelf,
  }) : super(key: key);

  final MessageModelData msg;
  final bool isSelf;

  // final String Function(String fileUrl, String fileName) onPressed;

  @override
  FileMessageState createState() => FileMessageState();
}

class FileMessageState extends ConsumerState<FileMessage> {
  String fileUrl = '';
  String fileName = '';
  String filePath = '';
  MainAxisAlignment align = MainAxisAlignment.start;
  String cachePath = '';

  @override
  void initState() {
    super.initState();
    fileUrl = utf8.decode(widget.msg.content!);
    filePath = OssService().getLocalFilePath(fileUrl) ?? '';
    if (filePath.isEmpty) {
      logger.e('FileMessage filepath is empty, maybe some bug happened');
    }
    fileName = p.basename(filePath);
    align = widget.isSelf ? MainAxisAlignment.end : MainAxisAlignment.start;
    logger.i('render FileMessage: ${widget.msg.msgId}, filePath: $filePath');
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
    var openDirectoryButton = Container(
      margin: const EdgeInsets.only(top: 15.0),
      constraints: const BoxConstraints(maxWidth: 600),
      child: IconButton(
        icon: const Icon(Icons.folder_open),
        tooltip: '打开文件所在文件夹',
        iconSize: 30,
        onPressed: () {
          if (filePath.isNotEmpty) {
            OpenFile.open(p.dirname(filePath));
          } else {
            logger.e(
                'Cannot open file because filepath is empty, maybe some bug happened');
          }
        },
      ),
    );
    var messageText = Container(
      margin: const EdgeInsets.all(5.0),
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: FloatingActionButton.extended(
          icon: const Icon(Icons.file_download_done),
          tooltip: _tooltip(),
          onPressed: () {
            if (filePath.isNotEmpty) {
              OpenFile.open(filePath);
            } else {
              logger.e(
                  'Cannot open file because filepath is empty, maybe some bug happened');
            }
          },
          label: Text(
            fileName,
            overflow: TextOverflow.ellipsis,
          )),
    );
    return Row(
      mainAxisAlignment: align,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.isSelf
          ? [openDirectoryButton, messageText, senderAvatar]
          : [senderAvatar, messageText, openDirectoryButton],
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
