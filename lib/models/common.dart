import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';

part 'common.mapper.dart';

@MappableClass()
class NetworkCard with NetworkCardMappable {
  final String name;
  final String ip;

  NetworkCard(this.name, this.ip);
}

enum ContentType {
  text(0),
  image(1),
  file(2);

  const ContentType(this.value);

  final int value;
}

enum Platform {
  desktop(0),
  webMobile(1),
  web(2);

  const Platform(this.value);

  final int value;
}

String responseTemplate(String? msg, [String? err]) {
  msg ??= 'ok';
  err ??= '';
  var ret = jsonEncode({'message': msg, 'error': err});
  return ret;
}
