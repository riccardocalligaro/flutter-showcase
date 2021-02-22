import 'package:f_logs/f_logs.dart';

import 'failures.dart';

Failure handleError(
  dynamic e, [
  StackTrace s,
]) {
  // log the errror

  if (e is Exception) {
  } else {
    e = Exception(e.toString());
  }

  print(e);
  print(s);
  // FLog.error(text: 'Got an error', exception: e, stacktrace: s);

  return Failure(e);
}
