import 'package:dio/dio.dart';
import './dio_interceptor.dart' as internal;

class DioInstance {
  DioInstance._() {
    _dio = Dio()..interceptors.add(internal.Interceptor());
  }

  static DioInstance get instance => DioInstance._();

  late final Dio _dio;

  Dio get dio => _dio;
}
