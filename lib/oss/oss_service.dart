import 'dart:io';

import 'package:localchat/extension/form_data.dart';
import 'package:localchat/extension/multipart.dart';
import 'package:localchat/extension/static_handler.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/models/common.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart';

abstract class IOssService {
  String upload(String msgId, filePath);

  Future<void> delete(String filePath);

  String? getLocalFilePath(String fileUrl);

  Handler downloadFileRouter(String msgId);

  // Handler fileList(Request request);
  Handler uploadFile();

  Handler deleteFile();
}

class OssService implements IOssService {
  static final OssService _inst = OssService._internal();

  factory OssService() {
    return _inst;
  }

  OssService._internal();

  final _defaultMimeTypeResolver = MimeTypeResolver();

  // key is msgId, value is file path
  final Map<String, String> _fileMap = {};

  @override
  Future<void> delete(String filePath) async {
    throw UnimplementedError();
  }

  @override
  String? getLocalFilePath(String fileUrl) {
    var splits = fileUrl.split('/');
    var msgId = splits[splits.length - 2];
    return _fileMap[msgId];
  }

  @override
  String upload(String msgId, filePath) {
    _fileMap[msgId] = filePath;
    var filename = p.basename(filePath);
    return '${utils.ossApiPath()}/$msgId/$filename';
  }

  /// Creates a shelf [Handler] that serves the file at [path].
  ///
  /// This returns a 404 response for any requests whose [Request.url] doesn't
  /// match [url]. The [url] defaults to the basename of [path].
  ///
  /// This uses the given [contentType] for the Content-Type header. It defaults
  /// to looking up a content type based on [path]'s file extension, and failing
  /// that doesn't sent a [contentType] header at all.
  @override
  Handler downloadFileRouter(msgId) {
    return (request) {
      var filePath = _getFileSystemPathByMsgId(msgId);
      if (filePath == null) {
        return Response.notFound('file from message $msgId not exist');
      }
      var filename = p.basename(filePath);
      final file = File(filePath);
      if (!file.existsSync()) {
        return Response.notFound(
            'file from message $msgId should be in $filePath, but it is not exist');
      }

      final mimeType = _defaultMimeTypeResolver.lookup(filePath);
      return handleFile(request, file, filename, () => mimeType);
    };
  }

  String _recordFile(String msgId, String filePath) {
    _fileMap[msgId] = filePath;
    return msgId;
  }

  String? _getFileSystemPathByMsgId(String msgId) {
    return _fileMap[msgId];
  }

  @override
  Handler deleteFile() {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  // @override
  // Handler fileList() {
  //   // TODO: implement fileList
  //   throw UnimplementedError();
  // }

  @override
  Handler uploadFile() {
    return (Request request) async {
      if (request.headers['token'] != "123456") {
        return Response.forbidden(
            responseTemplate('failed', 'upload file request denied'));
      }
      String? msgId = request.headers['msgId'];
      if (msgId == null || msgId.isEmpty) {
        return Response.forbidden(responseTemplate('failed',
            'upload file request denied because msgId header not exist'));
      }
      if (!request.isMultipart) {
        return Response.forbidden(responseTemplate('failed', 'not multipart'));
      }
      IOSink? fd;
      try {
        var formData = (await request.multipartFormDataList).first;
        // var formData = (await request.multipartFormData.toList()).first;
        var filename = formData.filename;
        if (filename == null) {
          return Response.ok(responseTemplate('failed', 'filename is null'),
              headers: {'content-type': "application/json"});
        }
        String filePath = utils.getDownloadPath(filename: filename);
        var targetFile = File(filePath);
        if (targetFile.existsSync()) {
          targetFile.deleteSync();
        }
        targetFile.createSync();
        fd = targetFile.openWrite();
        var data = await formData.part.readBytes();
        fd.add(data);
        await fd.flush();
        _recordFile(msgId, filePath);
        logger.i('receive $filename success, total bytes ${data.length}');
        return Response.ok(responseTemplate(msgId),
            headers: {'content-type': "application/json"});
      } catch (e) {
        return Response.internalServerError(
            body: responseTemplate('failed', e.toString()),
            headers: {'content-type': "application/json"});
      } finally {
        fd?.close();
      }
    };
  }
}

class OssSvcError extends Error {
  final String message;

  OssSvcError(this.message);

  @override
  String toString() => "Oss Service Error: $message";
}
