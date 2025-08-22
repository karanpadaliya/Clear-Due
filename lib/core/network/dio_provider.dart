// lib/core/network/dio_provider.dart

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/error/app_exception.dart';

Dio createDio(credentials) {
  final dio = Dio(
    BaseOptions(
      baseUrl: VariableBag.mainURL,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.options.headers['Authorization'] = 'Basic $credentials';
  dio.options.headers['Accept'] = 'application/json';
  dio.options.headers['key'] = VariableBag.mainKey;
  dio.options.headers['countryid'] = '101';
  dio.options.headers['languageid'] = '1';
  dio.options.headers['societyid'] = '1';
  dio.options.headers['header_device'] = 'android';
  dio.options.headers['headerappversion'] = '206';
  // TEMPORARY INTERCEPTOR FOR UI TESTING
  // dio.interceptors.add(
  //   InterceptorsWrapper(
  //     onRequest: (options, handler) {
  //       if (options.data != null && options.data is Map<String, dynamic>) {
  //         // Add a custom header for testing purposes
  //         // options.headers['X-Simulate-Error'] = 'true';
  //         if (options.data.containsKey('X-Simulate-Error')) {
  //           // Simulate a DioException with a 401 status code
  //           final response = Response(
  //             requestOptions: options,
  //             statusCode: 401,
  //             data: {'message': 'Mock Authentication Failed'},
  //           );
  //           return handler.reject(
  //             DioException(
  //               requestOptions: options,
  //               response: response,
  //               error: AppException(
  //                 message: 'Something went wrong. Please try again later.',
  //                 statusCode: 401,
  //               ),
  //               type: DioExceptionType.badResponse,
  //             ),
  //           );
  //         }
  //       }
  //       return handler.next(options);
  //     },
  //   ),
  // );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        print(
          '🚀 Request[${options.method}] => PATH:${options.baseUrl}${options.path}',
        );
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print(
          '✅ Response[${response.statusCode}]\nFrom ${response.realUri.origin}${response.realUri.path} \n=> ${response.data}',
        );
        return handler.next(response);
      },
      onError: (e, handler) {
        print('❌ Error[${e.response?.statusCode}] \n=> ${e.message}');
        FirebaseCrashlytics.instance.recordError(e, e.stackTrace);

        // Throw a custom, more specific exception
        final appException = _handleDioError(e);
        return handler.reject(
          DioException(
            requestOptions: e.requestOptions,
            error: appException,
            response: e.response,
            type: e.type,
          ),
        );
      },
    ),
  );
  return dio;
}

AppException _handleDioError(DioException error) {
  String errorMessage;
  switch (error.type) {
    case DioExceptionType.cancel:
      errorMessage = 'Request to the server was cancelled.';
      break;
    case DioExceptionType.connectionTimeout:
      errorMessage =
          'Connection timed out. Please check your internet connection.';
      break;
    case DioExceptionType.receiveTimeout:
      errorMessage =
          'Receiving timeout occurred in connection with API server.';
      break;
    case DioExceptionType.sendTimeout:
      errorMessage = 'Send timeout in connection with API server.';
      break;
    case DioExceptionType.badResponse:
      errorMessage = _handleStatusCode(error.response?.statusCode);
      break;
    case DioExceptionType.connectionError:
      errorMessage = 'Connection error. Please check your internet connection.';
      break;
    case DioExceptionType.unknown:
    default:
      errorMessage = 'Something went wrong. Please try again later.';
      break;
  }
  return AppException(
    message: errorMessage,
    statusCode: error.response?.statusCode,
  );
}

String _handleStatusCode(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request.';
    case 401:
      return 'Authentication failed.';
    case 403:
      return 'The authenticated user is not allowed to access the specified API endpoint.';
    case 404:
      return 'The requested resource does not exist.';
    case 500:
      return 'Internal server error.';
    default:
      return 'Oops something went wrong!';
  }
}
