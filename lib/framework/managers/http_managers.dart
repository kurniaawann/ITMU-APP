// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_itmu/framework/core/config/env_config.dart';
// import 'package:mobile_canvassing/features/auth/auth/presentation/bloc/auth_bloc.dart';
// import 'package:mobile_canvassing/features/auth/auth/presentation/bloc/auth_event.dart';
// import 'package:mobile_canvassing/service_locator.dart';
import 'package:mobile_itmu/framework/managers/dio_loggin_inceptor.dart';

// import 'package:dio_http_cache/dio_http_cache.dart';
// import '../../EnvConfig.baseUrl;
import '../core/exceptions/app_exceptions.dart';

abstract class HttpManager {
  Future<Response> get({
    required String url,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  Future<Response> post({
    String url,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
    FormData formData,
    bool isUploadImage = false,
  });
  Future<Response> patch({
    String url,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  Future<Response> put({
    String url,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
    FormData formData,
    bool isUploadImage = false,
  });

  Future<Response> delete({
    String url,
    Object? body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });
}

class AppHttpManager implements HttpManager {
  final LoggingInterceptor _loggingInterceptor;

  // static final AppHttpManager instance = AppHttpManager._instantiate();
  final String _baseUrl = EnvConfig.baseUrl;
  final Dio _dio = Dio();

  late Duration _httpTimeout;

  AppHttpManager()
      : _loggingInterceptor = LoggingInterceptor(
            // authLocal: serviceLocator(),
            // onUnauthorized: () {
            //   final authBloc = serviceLocator<AuthBloc>();
            //   authBloc.add(const LoggedOut(runPost: false));
            // },
            // authBloc: serviceLocator(),
            ) {
    _httpTimeout = const Duration(seconds: 3);

    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(_loggingInterceptor);
  }

  @override
  Future<Response> delete({
    String? url,
    Object? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio
          .delete(
        _queryBuilder(url, query),
        data: json.encode(body),
        options: Options(
          headers: _headerBuilder(headers),
        ),
      )
          .timeout(_httpTimeout, onTimeout: () {
        throw NetworkException();
      });
      return _returnResponse(response);
    } catch (error) {
      throw await handleError(error);
    }
  }

  @override
  Future<Response> get({
    String? url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio
          .get(
        _queryBuilder(url, query),
        data: body != null ? json.encode(body) : null,
      )
          .timeout(_httpTimeout, onTimeout: () {
        throw NetworkException();
      });
      return _returnResponse(response);
    } catch (error) {
      throw await handleError(error);
    }
  }

  @override
  Future<Response> post({
    String? url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  }) async {
    try {
      final response = await _dio
          .post(_queryBuilder(url, query),
              data: formData ?? (body != null ? json.encode(body) : null),
              options: Options(
                headers: _headerBuilder(headers),
              ))
          .timeout(_httpTimeout, onTimeout: () {
        throw NetworkException();
      });
      print("response");
      return _returnResponse(response);
    } catch (error) {
      throw await handleError(error);
    }
  }

  @override
  Future<Response> patch({
    String? url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio
          .patch(_queryBuilder(url, query),
              data: (body != null ? json.encode(body) : null),
              options: Options(
                headers: _headerBuilder(headers),
              ))
          .timeout(_httpTimeout, onTimeout: () {
        throw NetworkException();
      });
      print("response");
      return _returnResponse(response);
    } catch (error) {
      throw await handleError(error);
    }
  }

  @override
  Future<Response> put({
    String? url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  }) async {
    try {
      final response = await _dio
          .put(_queryBuilder(url, query),
              data: formData ?? (body != null ? json.encode(body) : null),
              options: Options(
                headers: _headerBuilder(headers),
              ))
          .timeout(_httpTimeout, onTimeout: () {
        throw NetworkException();
      });
      return _returnResponse(response);
    } catch (error) {
      throw await handleError(error);
    }
  }

  // private methods
  Map<String, String> _headerBuilder(Map<String, String>? headers) {
    headers ??= {};

    headers[HttpHeaders.acceptHeader] = 'application/json';
    if (headers[HttpHeaders.contentTypeHeader] == null) {
      headers[HttpHeaders.contentTypeHeader] = 'application/json';
    }

    if (headers != null && headers.isNotEmpty) {
      headers.forEach((key, value) {
        headers?[key] = value;
      });
    }

    return headers;
  }

  String _queryBuilder(String? path, Map<String, dynamic>? query) {
    final buffer = StringBuffer();
    buffer.write(EnvConfig.baseUrl + path.toString());

    if (query != null) {
      if (query.isNotEmpty) {
        buffer.write('?');
      }
      query.forEach((key, value) {
        buffer.write('$key=$value&');
      });
    }
    if (kDebugMode) {
      print(buffer);
    }
    return buffer.toString();
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  dynamic _returnResponse(Response response) {
    var data = response;
    final responseJson = data;
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      // if (EnvConfig.baseUrl {
      // printWarning('Api response success with $responseJson');
      // }

      return responseJson;
    } else {
      // if (EnvConfig.baseUrl {
      // printError('Api response failed with $response');
      // }

      var message = '';
      try {
        message = response.data['message'];
      } catch (e) {
        message = '';
      }

      if (message.isNotEmpty) {
        if (message.toUpperCase() == 'INVALID CREDENTIALS' ||
            message.toUpperCase() == 'MISSING AUTHENTICATION') {
          if (kDebugMode) {
            print('Force Logout...');
          }

          throw InvalidCredentialException(
              "Sesi telah habis, harap login kembali");
        }
      } else if (response.data.runtimeType == String) {
        message = removeAllHtmlTags(response.data);
        if (message.contains('502')) {
          // Bad Gateway
          message = '502 Bad Gateway';
        }
      }

      switch (response.statusCode) {
        case 400:
          throw BadRequestException(
              message.isNotEmpty ? message : "Bad request");
        case 401:
        case 403:
          throw UnauthorisedException(
              message.isNotEmpty ? message : "Invalid token");
        case 404:
          throw NotFoundException(message.isNotEmpty ? message : "Not found");
        case 422:
          throw UnauthorisedException(
              message.isNotEmpty ? message : "Invalid credentials");
        case 406:
          throw NotAcceptableException(
              message.isNotEmpty ? message : "Not Acceptable");
        case 500:
        default:
          throw FetchDataException(
              message.isNotEmpty ? message : "Unknown Error");
      }
    }
  }

  Future<dynamic> handleError(dynamic error) async {
    if (error is DioException) {
      final response = error.response;
      late final dynamic message;
      if (response?.data is Map<String, dynamic>) {
        message = response?.data['message'];
      } else {
        message = '';
      }

      switch (response?.statusCode) {
        case 400:
          throw BadRequestException(
              message.isNotEmpty ? message : "Bad request");
        case 401:
          throw InvalidCredentialException(
              message.isNotEmpty ? message : "Invalid credentials");
        case 403:
          throw UnauthorisedException(
              message.isNotEmpty ? message : "Invalid token");
        case 404:
          throw NotFoundException(
              message.isNotEmpty ? message : "Server Error");
        case 422:
          throw UnauthorisedException(
              message.isNotEmpty ? message : "Invalid credentials");
        case 417:
          throw ServerException(message.isNotEmpty ? message : "Error");
        case 406:
          throw NotAcceptableException(
              message.isNotEmpty ? message : "Not Acceptable");
        case 500:
        default:
          throw FetchDataException(
              message.isNotEmpty ? message : "Unknown Error");
      }
    }
    throw FetchDataException("Unknown Error");
  }
}
