import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class FileWriter {
  static final FileWriter _inst = FileWriter._internal();

  factory FileWriter() {
    return _inst;
  }

  FileWriter._internal();

  final Map<String, IOSink?> _fdMap = {};
  final Map<String, int?> _fSizeMap = {};

  IOSink? getFd(String filePath, {bool createIfNotExist = false}) {
    if (_fdMap[filePath] == null && createIfNotExist) {
      return _createFd(filePath);
    }
    return _fdMap[filePath];
  }

  IOSink _createFd(String filePath) {
    var targetFile = File(filePath);
    if (targetFile.existsSync()) {
      targetFile.deleteSync();
    }
    targetFile.createSync();
    var fd = targetFile.openWrite();
    _fdMap[filePath] = fd;
    _fSizeMap[filePath] = 0;
    return _fdMap[filePath]!;
  }

  writeSync(String filePath, Uint8List data) {
    getFd(filePath, createIfNotExist: true)!.add(data);
    _fSizeMap[filePath] = _fSizeMap[filePath]! + data.length;
  }

  int getSize(String filePath) {
    return _fSizeMap[filePath] ?? -1;
  }

  flush(String filePath) async {
    await getFd(filePath)?.flush();
    await getFd(filePath)?.close();
    _fdMap[filePath] = null;
    _fSizeMap[filePath] = null;
  }
}
