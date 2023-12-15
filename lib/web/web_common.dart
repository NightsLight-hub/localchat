import 'dart:html';

import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:dio/dio.dart';

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

String get selfId => getUserModelData()!.userId;

logI(Object? arg) {
  window.console.log(arg);
}

logW(Object? arg) {
  window.console.warn(arg);
}

logE(Object? arg) {
  window.console.error(arg);
}

logD(Object? arg) {
  window.console.debug(arg);
}

var dio = Dio(BaseOptions(
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
));
