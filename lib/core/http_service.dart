import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tractian_challenge/core/configs.dart';
import 'package:tractian_challenge/core/http_header_help.dart';

typedef HttpLibraryMethod<T> = Future<Response<T>> Function();

abstract class HttpService {
  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters});
  Future<Response<T>> post<T>(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters});
  Future<Response<T>> put<T>(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters});
  Future<Response<T>> delete<T>(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters});
}

class DioService implements HttpService {
  final Dio dio;
  final Config config;
  DioService(this.dio, this.config) {
    _config();
  }

  void _config() async {
    late String baseUrl;
    if (config.isProduction) {
      baseUrl = config.baseUrl;
    }
    if (config.isStaging) {
      baseUrl = config.baseUrl;
    }
    if (config.isLocal) baseUrl = 'http://localhost:8080';
    dio.options =
        BaseOptions(baseUrl: baseUrl, headers: HttpHeaderHelp.headers());
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _mapException(
      () => dio.get(
        path,
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _mapException(
      () => dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _mapException(
      () => dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _mapException(
      () => dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      ),
    );
  }

  Future<Response<T>> _mapException<T>(HttpLibraryMethod<T> method) async {
    try {
      return await method();
    } on DioException catch (exception) {
      switch (exception.type) {
        case DioExceptionType.cancel:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.badResponse:
          break;
        default:
          rethrow;
      }
      rethrow;
    } catch (exception) {
      rethrow;
    }
  }
}
