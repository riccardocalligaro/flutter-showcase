import 'dart:io';

mixin MZApiConfig {
  static String apiUrl = '${_getProductionBaseURL()}';
}

String _getProductionBaseURL() {
  return Platform.isAndroid ? 'http://10.0.2.2:8084' : 'http://127.0.0.1:8084';
}
