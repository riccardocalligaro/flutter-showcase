import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../infrastructure/log/logger.dart';
import 'mz_api_config.dart';

// navigator for alice http inspector
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class MZDioClient {
  static Dio createDio() {
    final options = BaseOptions(
      baseUrl: MZApiConfig.apiUrl,
      contentType: ContentType.json.value,
      responseType: ResponseType.json,
    );

    final dio = Dio(options);

    // certificate to solve problems with android simulator
    if (kDebugMode && Platform.isAndroid) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options) {
          Logger.info(
            '🌐 [DioREQUEST] -> ${options.path}',
          );
        },
        onResponse: (response) {
          Logger.info(
            // ignore: lines_longer_than_80_chars
            '🌐 [DioEND] -> Response -> ${response.statusCode}[${response.request.path}] ${response.request.method}  ${response.request.responseType}',
          );

          // continue with the chain
          return response;
        },
        onError: (error) async {
          if (error.response != null) {
            Logger.networkError(
              '🤮 [DioERROR] ${error.type}',
              Exception(
                // ignore: lines_longer_than_80_chars
                'Url: [${error.request.baseUrl}] status:${error.response.statusCode} type:${error.type} Data: ${error.response.data} message: ${error.message}',
              ),
            );
          } else {
            Logger.error(error, null, text: '🚫 [DioERROR] $error');
          }

          return error;
        },
      ),
    );

    return dio;
  }
}
