import 'dart:html';

import 'package:localchat/models/dbmodels_adapter.dart';

UserModelData? _user;

UserModelData? getUserModelData() {
  return _user;
}

UserModelData? setUserModelData(UserModelData? u) {
  _user = u;
  return _user;
}

logI(Object? arg) {
  window.console.log(arg);
}

logW(Object? arg) {
  window.console.warn(arg);
}

logE(Object? arg) {
  window.console.error(arg);
}
