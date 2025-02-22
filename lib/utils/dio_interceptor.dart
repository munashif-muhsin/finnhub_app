import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Interceptor extends InterceptorsWrapper {
  Interceptor()
      : super(
          onError: _onError,
          onRequest: _onRequest,
          onResponse: _onResponse,
        );

  static void _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(error);
  }

  static void _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final params = <String, dynamic>{
      // Set token to all requests
      "token": dotenv.get('API_KEY'),
    };

    options.queryParameters.addAll(params);

    if (kDebugMode) {
      print("URL (${options.method}): ${options.uri}, Data: ${options.data}");
    }

    handler.next(options);
  }

  static void _onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.resolve(response);
  }
}
