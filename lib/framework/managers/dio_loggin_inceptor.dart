import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_itmu/framework/core/logger/config_logger.dart';

/// [LoggingInterceptor] is a custom Dio interceptor that adds the Authorization header,
/// logs request and response details, and handles errors including unauthorized responses.
class LoggingInterceptor extends Interceptor {
  // final AuthLocalDataSource _authLocal;
  final VoidCallback? onUnauthorized;
  // final AuthBloc _authBloc;

  /// Constructs a [LoggingInterceptor].
  ///
  /// The [authBloc] parameter is used to handle authentication state changes,
  /// and [authLocal] is used to retrieve and clear the authentication token.
  LoggingInterceptor({
    // required AuthLocalDataSource authLocal,
    this.onUnauthorized,
  });
  // : _authLocal = authLocal;
  // _authBloc = authBloc;

  /// Intercepts the request and adds the Authorization header if a token exists.
  ///
  /// Logs the request method, URI, headers, and data.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add the Authorization header if the token exists
    // if (_authLocal.token != null) {
    //   options.headers.addAll({
    //     HttpHeaders.authorizationHeader: 'Bearer ${_authLocal.token}',
    //   });
    // }

    // Format headers for logging
    String headers = '';
    options.headers.forEach((key, value) {
      headers += '| $key: $value';
    });

    logger().i(
        '''| [DIO] Request: ${options.method} ${options.uri}\n| ${(options.data is FormData) ? (options.data as FormData).files : options.data}\n| Headers:\n$headers''');
    super.onRequest(options, handler);
  }

  /// Logs the response details including URI, status code, and data.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    logger().i(
        '| [DIO] Response ${response.requestOptions.uri} [code ${response.statusCode}]: ${response.data.toString()}');

    super.onResponse(response, handler);
  }

  /// Logs error details and handles unauthorized errors by clearing the token and triggering logout.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    logger().e(
        '| [DIO] Error ${err.requestOptions.uri} ${err.error}: ${err.response.toString()}');

    // Check if the error response data contains an 'unauthorized' message
    if (err.response?.data is Map<String, dynamic>) {
      if ((err.response?.data != null &&
              (err.response?.data['message'] is String? &&
                  err.response?.data['error'] is String?) &&
              err.response?.statusCode == 401)
          //      &&
          // _authLocal.token != null
          ) {
        final message =
            (err.response!.data['message'] as String?)?.toLowerCase();
        final errorMsg =
            (err.response!.data['error'] as String?)?.toLowerCase();
        if ((message?.contains('unauthorized') ?? false) ||
            (errorMsg?.contains('unauthorized') ?? false)) {
          // Clear the token and trigger logout if unauthorized
          // _authLocal.clearToken();
          onUnauthorized?.call();
          // _authBloc.add(LoggedOut());
        }
      }
    }
    super.onError(err, handler);
  }
}
