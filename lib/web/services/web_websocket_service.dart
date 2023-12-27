import 'dart:async';
import 'dart:convert';
import 'package:localchat/web/web_common.dart' as common;
import 'package:localchat/http/websocket_message.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/state/messages_state.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:localchat/utils.dart' as utils;

class WebWsService {
  static final WebWsService _inst = WebWsService._internal();

  factory WebWsService() {
    return _inst;
  }

  WebWsService._internal();

  WebSocketChannel? channel;
  Uri? uri;
  final Map<String, Function(String token)> _applyForSendingFileHandlers = {};

  void init(String uri) {
    common.logI('WebWsService init');
    this.uri = Uri.parse(uri);
    _reConn();
  }

  _registerUser() {
    var user = common.getUserModelData()!;
    common.logI('register user ${user.nickName}');
    WebsocketMessage wsMsg = WebsocketMessage.registerUser(user);
    send(wsMsg);
  }

  // process websocket conn
  _reConn() async {
    try {
      channel = HtmlWebSocketChannel.connect(uri!);
      common.logI('wait websocket channel to be ready');
      await channel!.ready;
      common.logI('websocket channel is ready');
      // registerUser should be called when websocket connection is established.
      _registerUser();
      await _listenWsMsg();
    } catch (e, s) {
      common.logW('websocket connect failed, err is $e, stack is $s');
      channel = null;
    }
  }

  _listenWsMsg() async {
    channel!.stream.listen((message) {
      try {
        var data = jsonDecode(message);
        var wsMsg = WebsocketMessage.fromJson(data);
        switch (wsMsg.type) {
          case WsMsgType.sendMessage:
            var msgModel = MessageModelData.fromJson(jsonDecode(wsMsg.body));
            utils
                .getMainRef()
                .read(messagesNotifierProvider.notifier)
                .add(msgModel);
            break;
          default:
            common.logW('unknown websocket message: $message');
            break;
        }
      } catch (e) {
        common.logW(e);
      }
    }, onError: (err) async {
      var code = channel?.closeCode;
      var reason = channel?.closeReason;
      common.logI('ws channel close [$code] $reason, $err');
      channel = null;
      _reConn();
    }, onDone: () async {
      var code = channel?.closeCode;
      var reason = channel?.closeReason;
      common.logI('ws channel close [$code] $reason');
      channel = null;
      _reConn();
    });
  }

  send(WebsocketMessage msg) {
    if (channel == null) {
      common.logE('websocket channel disconnected');
    } else {
      channel?.sink.add(jsonEncode(msg));
    }
  }

  addApplyForSendingFileHandler(String msgId, Function(String token) handler) =>
      _applyForSendingFileHandlers[msgId] = handler;

  removeApplyForSendingFileHandler(String msgId) =>
      _applyForSendingFileHandlers.remove(msgId);
}
