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
  Timer? _timer;
  final Map<String, Function(String token)> _applyForSendingFileHandlers = {};

  void init(String uri) {
    common.logI('WebWsService init');
    this.uri = Uri.parse(uri);
    _reConn();
  }

  // process websocket conn
  _reConn() async {
    try {
      channel = HtmlWebSocketChannel.connect(uri!);
      common.logI('wait websocket channel to be ready');
      await channel!.ready;
      common.logI('websocket channel is ready');
      await _listenWsMsg();
    } catch (e, s) {
      common.logW('websocket connect failed, err is $e, stack is $s');
      channel = null;
    }

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (channel == null || channel?.closeCode != null) {
        common.logW('websocket connect failed, try to reconnect');
        _reConn();
      }
    });
  }

  _listenWsMsg() async {
    channel!.stream.listen((message) {
      common.logD('get msg from ws, $message');
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
          case WsMsgType.sendFilePermit:
            var data = wsMsg.body;
            List<String> splits = data.split(' ');
            if (splits.length != 2) {
              common.logE('invalid send file permit msg');
              break;
            }
            var msgId = splits[0];
            var token = splits[1];
            var handler = _applyForSendingFileHandlers[msgId];
            if (handler != null) {
              handler(token);
            } else {
              common.logW('no handler for msgId $msgId');
            }
            break;
          default:
            common.logW('unknown websocket message: $message');
            break;
        }
      } catch (e) {
        common.logW(e);
      }
    }, onError: (err) {
      common.logE('get error from ws, $err');
    }, onDone: () {
      var code = channel?.closeCode;
      var reason = channel?.closeReason;
      common.logI('ws channel close [$code] $reason');
      channel = null;
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
