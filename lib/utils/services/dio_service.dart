import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

///This is a simple dio service to handle api calls.
///We can add more features to it later, like token refresh, different base urls for different environments, etc.

class DioService {
  static String baseUrl = 'https://restcountries.com/v3.1';

  static Dio getDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: getHeader(),
      ),
    );
    dio.interceptors.add(getInterceptor());
    return dio;
  }

  static getHeader() {
    var header = {
      'content-Type': 'application/json',
    };

    debugPrint('header $header');
    return header;
  }

  static InterceptorsWrapper getInterceptor() {
    var logger = Logger();
    return InterceptorsWrapper(
      onRequest: (requestOptions, handler) {
        logger.d(
          'REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}'
          '=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}',
        );
        logger.d('REQUEST DATA==> ${requestOptions.data.toString()}');
        return handler.next(requestOptions);
      },
      onResponse: (response, handler) {
        logger.i('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
        return handler.next(response);
      },
      onError: (err, handler) {
        logger.e('RESPONSE[${err.response?.statusCode}]', error: [err]);
        logger.e('RESPONSE[BODY]', error: [err.response?.data]);
        return handler.next(err);
      },
    );
  }
}
