import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:localchat/extension/multipart.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:localchat/http/websocket_service.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;
import 'package:shelf_web_socket/shelf_web_socket.dart';

var restRouter = shelf_router.Router();

shelf.Handler routes() {
  restRouter.get('/api/v1/hello', (shelf.Request request) {
    var response = {'message': 'localchat API is alive'};
    return shelf.Response.ok(jsonEncode(response));
  });

  restRouter.post('/api/v1/file', (shelf.Request request) async {
    if (request.headers['token'] != "123456") {
      return shelf.Response.forbidden('upload file request denied');
    }
    // if (request.headers['content-index'] ) {

    // }

    var fd = File(utils.getDownloadPath(filename: 'test')).openWrite();

    if (request.isMultipart) {
      await for (var part in request.parts) {
        await part.forEach(fd.add);
      }
    }
  });

  restRouter.mount(
      '/front/',
      shelf_static.createStaticHandler('build/web/',
          defaultDocument: 'index.html'));

  return restRouter.call;
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
