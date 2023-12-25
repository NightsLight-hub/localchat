import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

// Define various tool functions that can be used on both desktop and web.

int _readStreamChunkSize = 1 * 1024 * 1024;

late WidgetRef _mainRef;

setMainRef(WidgetRef ref) {
  _mainRef = ref;
}

WidgetRef getMainRef() {
  return _mainRef;
}

double getCurrentTimestampByMill() {
  return DateTime.now().millisecondsSinceEpoch.toDouble();
}

String uuid() {
  return const Uuid().v4();
}

String createDownloadPath() {
  var downloadPath = p.absolute('cache', 'download');
  var downloadDir = Directory(downloadPath);
  if (!downloadDir.existsSync()) {
    downloadDir.createSync(recursive: true);
  }
  return downloadPath;
}

String getDownloadPath({String? filename}) {
  var downloadPath = createDownloadPath();
  if (filename != null) {
    downloadPath = p.join(downloadPath, filename);
  }
  return downloadPath;
}

String ossApiPath() {
  return 'api/v1/file';
}

showSnackBar(BuildContext context, Widget contentWidget, {int width = 400}) {
  var h = MediaQuery.of(context).size.height;
  var w = MediaQuery.of(context).size.width;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: contentWidget,
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      bottom: h - 80,
      left: w > width ? (w - width) / 2 : 0,
      right: w > width ? (w - width) / 2 : 0,
    ),
    showCloseIcon: true,
  ));
}

Stream<List<int>> openFileReadStream(XFile file) async* {
  int start = 0;
  final fileSize = await file.length();
  while (start < fileSize) {
    final end = start + _readStreamChunkSize > fileSize
        ? fileSize
        : start + _readStreamChunkSize;
    final blob = file.openRead(start, end);
    final result = await blob.first;
    yield result;
    start += _readStreamChunkSize;
  }
}

var _darkTheme = ThemeData.dark(useMaterial3: true).copyWith();
var _lightTheme = ThemeData.light(useMaterial3: true).copyWith();

ThemeData darkTheme() {
  return _darkTheme;
}

ThemeData lightTheme() {
  return _lightTheme;
}
