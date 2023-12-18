import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:localchat/extension/shelf_cors.dart';
import 'package:localchat/http/websocket_service.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/models/common.dart';
import 'package:localchat/oss/oss_service.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;
import 'package:shelf_web_socket/shelf_web_socket.dart';

final restRouter = shelf_router.Router();
final ossService = OssService();

shelf.Handler routes() {
  restRouter.get('/api/v1/hello', (shelf.Request request) {
    var response = {'message': 'localchat API is alive'};
    return shelf.Response.ok(jsonEncode(response));
  });

  restRouter.get('/api/v1/asynchello', (shelf.Request request) async {
    await Future.delayed(const Duration(seconds: 2));
    return shelf.Response.ok(responseTemplate('ok'),
        headers: {'content-type': "application/json"});
  });

  restRouter.post('/${utils.ossApiPath()}', ossService.uploadFile());

  restRouter.get('/${utils.ossApiPath()}/<msgId|.*>',
      (shelf.Request request, String msgId) async {
    msgId = msgId.split('/').first;
    return ossService.downloadFileRouter(msgId).call(request);
  });

  restRouter.mount(
      '/front/',
      shelf_static.createStaticHandler('build/web/',
          defaultDocument: 'index.html'));

  var rootHandler = const Pipeline()
      .addMiddleware(corsHeaders(headers: null))
      .addHandler(restRouter.call);
  return rootHandler;
}

FutureOr<shelf.Response> websocketHandler(Request request) {
  return webSocketHandler((webSocketChannel) {
    WebSocketService().addChannel(request, webSocketChannel);
  }, pingInterval: const Duration(seconds: 5))(request);
}

String addDownloadMount(String directory, String fileName) {
  String path = '/download-${utils.uuid()}';
  restRouter.mount(path,
      shelf_static.createStaticHandler(directory, defaultDocument: fileName));
  logger.i('mount $directory, $fileName');
  return '$path/$fileName';
}

// shelf.Handler websocketRouter() {
//   return webSocketHandler((webSocketChannel) {
//     WebSocketService().addChannel(webSocketChannel);
//   }, pingInterval: const Duration(seconds: 5));
// }
