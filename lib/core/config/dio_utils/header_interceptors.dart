import 'dart:async';

import 'package:dio/dio.dart';

import '../../utils/loggers.dart';

//<=================Places Headers================>

class PlacesInterceptor extends Interceptor {
  final Dio dio;
  PlacesInterceptor({
    required this.dio,
  });

  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.next(options);
    if (options.data != null) {
      debugLog('[URL]${options.uri}');
      debugLog("[BODY] ${options.data}");
      debugLog("[METHOD] ${options.method}");
    }
    return options;
  }

  @override
  FutureOr<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(err);
    return err;
  }

  @override
  FutureOr<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    debugLog("Response: ${response.data}");
    handler.next(response);
    return response;
  }
}

//<=================Cloudinary Headers================>

class CloudinaryInterceptor extends Interceptor {
  final Dio dio;
  CloudinaryInterceptor({
    required this.dio,
  });

  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.next(options);
    if (options.data != null) {
      debugLog('[URL]${options.uri}');
      debugLog("[BODY] ${options.data}");
      debugLog("[METHOD] ${options.method}");
    }
    return options;
  }

  @override
  FutureOr<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(err);
    return err;
  }

  @override
  FutureOr<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    debugLog("Response: ${response.data}");
    handler.next(response);
    return response;
  }
}
