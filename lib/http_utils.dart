import 'package:dio/dio.dart';

import 'logger.dart';

var dio = Dio(BaseOptions(
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
));

class HttpUtil {
  HttpUtil._();

  static Future init() async {
    // add interceptors
    // dio
    //   ..interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //   ))
    // // ..interceptors.add(HttpFormatter())
    //   ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    //     // Do something before request is sent
    //     return handler.next(options); //continue
    //     // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
    //     // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    //     //
    //     // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
    //     // 这样请求将被中止并触发异常，上层catchError会被调用。
    //   }, onResponse: (response, handler) {
    //     // Do something with response data
    //     return handler.next(response); // continue
    //     // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
    //     // 这样请求将被中止并触发异常，上层catchError会被调用。
    //   }, onError: (DioError e, handler) {
    //     // Do something with response error
    //     return handler.next(e); //continue
    //     // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
    //     // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    //   }));

    // 配置dio实例
    // dio.options.baseUrl = Config.imApiUrl;
    dio.options.connectTimeout = const Duration(seconds: 30); //30s
    dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  static String get operationID =>
      DateTime.now().millisecondsSinceEpoch.toString();

  /// fileType: file = "1",video = "2",picture = "3"
  // static Future<String> uploadImageForMinio({
  //   required String path,
  //   bool compress = true,
  // }) async {
  //   String fileName = path.substring(path.lastIndexOf("/") + 1);
  //   // final mf = await MultipartFile.fromFile(path, filename: fileName);
  //   String? compressPath;
  //   if (compress) {
  //     File? compressFile = await IMUtils.compressImageAndGetFile(File(path));
  //     compressPath = compressFile?.path;
  //     Logger.logger.i('compressPath: $compressPath');
  //   }
  //   final bytes = await File(compressPath ?? path).readAsBytes();
  //   final mf = MultipartFile.fromBytes(bytes, filename: fileName);
  //
  //   var formData = FormData.fromMap({
  //     'operationID': '${DateTime.now().millisecondsSinceEpoch}',
  //     'fileType': 1,
  //     'file': mf
  //   });
  //
  //   var resp = await dio.post<Map<String, dynamic>>(
  //     "${Config.imApiUrl}/third/minio_upload",
  //     data: formData,
  //     options: Options(headers: {'token': DataSp.imToken}),
  //   );
  //   return resp.data?['data']['URL'];
  // }

  static Future download(
    String url, {
    required String savePath,
    CancelToken? cancelToken,
    Function(int count, int total)? onProgress,
  }) {
    return dio.download(
      url,
      savePath,
      options: Options(receiveTimeout: const Duration(minutes: 10)),
      cancelToken: cancelToken,
      onReceiveProgress: onProgress ??
          (received, total) {
            if (total <= 0) return;
            print(
                'percentage: ${(received / total * 100).toStringAsFixed(0)}%');
          },
    );
  }
}
