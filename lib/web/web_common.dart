import 'dart:html';

import 'package:localchat/models/dbmodels_adapter.dart';

String selfId = 'self';

UserModelData? _user;

String _address = '';

set address(String a) {
  _address = a;
}

String get address => _address;

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
