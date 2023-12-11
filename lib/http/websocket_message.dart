import 'dart:convert';

import 'package:localchat/models/dbmodels_adapter.dart';

enum WsMsgType {
  registerUser(value: 0),
  sendMessage(value: 1);

  const WsMsgType({required this.value});

  final int value;
}

class WebsocketMessage {
  late WsMsgType type;
  late String body;

  Map<String, dynamic> toJson() {
    return {
      'type': type.value,
      'body': body,
    };
  }

  WebsocketMessage.fromJson(Map<String, dynamic> data) {
    type = WsMsgType.values[data['type']];
    body = data['body'];
  }

  WebsocketMessage.registerUser(UserModelData user) {
    type = WsMsgType.registerUser;
    body = jsonEncode(user);
  }

  WebsocketMessage.sendMessage(MessageModelData messageModel) {
    type = WsMsgType.sendMessage;
    body = jsonEncode(messageModel);
  }
}
