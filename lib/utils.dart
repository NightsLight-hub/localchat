import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

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
