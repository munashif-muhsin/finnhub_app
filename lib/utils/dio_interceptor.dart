import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Interceptor extends InterceptorsWrapper {
  /// Creates a new interceptor instance
  Interceptor()
      : super(
          onError: _onError,
          onRequest: _onRequest,
          onResponse: _onResponse,
        );

  /// Handles API request errors
  ///
  /// [error] The error details
  /// [handler] The error handler to process the error
  static void _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(error);
  }

  /// Processes outgoing API requests
  ///
  /// [options] The request options
  /// [handler] The request handler to process the request
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

  /// Processes API responses
  ///
  /// [response] The API response
  /// [handler] The response handler to process the response
  static void _onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.resolve(response);
  }
}
