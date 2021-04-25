import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:museo_zuccante/core/infrastructure/error/types/failures.dart';
import 'package:museo_zuccante/core/infrastructure/log/logger.dart';

Failure handleError(
  dynamic e, [
  StackTrace s,
]) {
  if (e is Exception) {
  } else {
    e = Exception(e);
  }
  // log the errror
  Logger.error(e, s);

  if (e is DioError) {
    if (e is TimeoutException || e is SocketException || e.response == null) {
      return NetworkFailure(dioError: e);
    } else if (e.response.statusCode >= 500) {
      return ServerFailure(e);
    } else {
      return NetworkFailure(dioError: e);
    }
  } else {
    // if (e is SqliteException || e is MoorWrappedException) {
    //   return DatabaseFailure();
    // }
    return GenericFailure(e: e);
  }
}
