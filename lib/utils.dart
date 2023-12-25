import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

// Define various tool functions that can be used on both desktop and web.

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
    backgroundColor: Colors.white30.withOpacity(0.4),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      bottom: h - 40,
      left: w > width ? (w - width) / 2 : 0,
      right: w > width ? (w - width) / 2 : 0,
    ),
    showCloseIcon: true,
  ));
}

var _darkTheme = ThemeData.dark(useMaterial3: true).copyWith();
var _lightTheme = ThemeData.light(useMaterial3: true).copyWith();

ThemeData darkTheme() {
  return _darkTheme;
}

ThemeData lightTheme() {
  return _lightTheme;
}
