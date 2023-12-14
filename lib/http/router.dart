import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:localchat/extension/form_data.dart';
import 'package:localchat/extension/multipart.dart';
import 'package:localchat/extension/shelf_cors.dart';
import 'package:localchat/http/websocket_service.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/utils.dart' as utils;
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

  restRouter.get('/api/v1/asynchello', (shelf.Request request) async {
    await Future.delayed(const Duration(seconds: 2));
    return shelf.Response.ok(responseTemplate('ok'),
        headers: {'content-type': "application/json"});
  });

  // restRouter.post('/api/v1/file', (shelf.Request request) async {
  //   logger.i('path /api/v1/file recive file request');
  //   if (request.headers['token'] != "123456") {
  //     return shelf.Response.forbidden(
  //         responseTemplate('failed', 'upload file request denied'));
  //   }
  //   if (!request.isMultipart) {
  //     return shelf.Response.forbidden(
  //         responseTemplate('failed', 'not multipart'));
  //   }
  //   return shelf.Response.ok(responseTemplate('ok'),
  //       headers: {'content-type': "application/json"});
  // });

  restRouter.post('/api/v1/file', (shelf.Request request) async {
    if (request.headers['token'] != "123456") {
      return shelf.Response.forbidden(
          responseTemplate('failed', 'upload file request denied'));
    }
    if (!request.isMultipart) {
      return shelf.Response.forbidden(
          responseTemplate('failed', 'not multipart'));
    }
    IOSink? fd;
    try {
      var formData = (await request.multipartFormDataList).first;
      // var formData = (await request.multipartFormData.toList()).first;
      var filename = formData.filename;
      if (filename == null) {
        return shelf.Response.ok(responseTemplate('failed', 'filename is null'),
            headers: {'content-type': "application/json"});
      }
      var targetFile = File(utils.getDownloadPath(filename: filename));
      if (targetFile.existsSync()) {
        targetFile.deleteSync();
      }
      targetFile.createSync();
      fd = targetFile.openWrite();
      var data = await formData.part.readBytes();
      fd.add(data);
      await fd.flush();
      logger.i('receive $filename success, total bytes ${data.length}');
      return shelf.Response.ok(responseTemplate('ok'),
          headers: {'content-type': "application/json"});
    } catch (e) {
      return shelf.Response.ok(responseTemplate('failed', e.toString()),
          headers: {'content-type': "application/json"});
    } finally {
      fd?.close();
    }
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

String responseTemplate(String? msg, [String? err]) {
  msg ??= 'ok';
  err ??= '';
  var ret = jsonEncode({'message': msg, 'error': err});
  return ret;
}

// shelf.Handler websocketRouter() {
//   return webSocketHandler((webSocketChannel) {
//     WebSocketService().addChannel(webSocketChannel);
//   }, pingInterval: const Duration(seconds: 5));
// }
