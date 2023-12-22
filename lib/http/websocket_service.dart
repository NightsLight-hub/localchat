import 'dart:convert';

import 'package:localchat/http/websocket_message.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/state/messages_state.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:shelf/shelf.dart';
import 'package:web_socket_channel/web_socket_channel.dart' as $websocket;

import '../models/dbmodels_adapter.dart';
import '../state/users_state.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();

  factory WebSocketService() => _instance;

  WebSocketService._internal();

  Map<String, $websocket.WebSocketChannel> addressChannelMap = {};
  Map<String, String> userAddressMap = {};

  addChannel(Request request, $websocket.WebSocketChannel channel) {
    // every client will connect to the server using websocket.
    String address = '${request.url.host}:${request.url.port}';
    addressChannelMap[address] = channel;
    channel.stream.listen((message) {
      logger.t('message: $message');
      try {
        var data = jsonDecode(message);
        var wsMsg = WebsocketMessage.fromJson(data);
        switch (wsMsg.type) {
          case WsMsgType.registerUser:
            var userModel = UserModelData.fromJson(jsonDecode(wsMsg.body));
            userAddressMap[userModel.userId] = address;
            logger.i('add user ${userModel.nickName}, id ${userModel.userId}');
            utils
                .getMainRef()
                .read(usersNotifierProvider.notifier)
                .add(userModel);
            break;
          case WsMsgType.sendMessage:
            var msgModel = MessageModelData.fromJson(jsonDecode(wsMsg.body));
            _processMessage(msgModel, message);
            break;
          default:
            logger.i('unknown websocket message: $message');
            break;
        }
      } catch (e) {
        logger.e(e);
      }
    }, onError: (error) {
      logger.e(
          'listen websocket $address channel error: $error, reason: ${channel.closeReason}');
      addressChannelMap.remove(address);
    });
  }

  _processMessage(MessageModelData msgModel, String rawWsMsg) {
    utils.getMainRef().read(messagesNotifierProvider.notifier).add(msgModel);
    for (var user in userAddressMap.keys) {
      if (msgModel.senderID == user) {
        continue;
      }
      sendToUser(user, rawWsMsg);
    }
  }

  sendToUser(String userId, String msg) {
    var address = userAddressMap[userId];
    if (address == null) {
      logger.e('user $userId not found');
      return;
    }
    var channel = addressChannelMap[address];
    if (channel == null) {
      logger.e('websocket channel from $address not exist');
      return;
    }
    channel.sink.add(msg);
    logger.i('send msg to $userId');
  }

  sendMessage(MessageModelData message) {
    for (var ent in addressChannelMap.entries) {
      logger.i('send msg to ${ent.key}');
      ent.value.sink.add(jsonEncode(WebsocketMessage.sendMessage(message)));
    }
  }
}
