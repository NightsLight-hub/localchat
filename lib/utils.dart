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

String getDownloadPath({String? filename}) {
  var downloadPath = p.absolute('cache/download');
  if (filename != null) {
    downloadPath = p.join(downloadPath, filename);
  }
  return downloadPath;
}
