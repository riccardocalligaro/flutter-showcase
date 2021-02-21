import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class Failure {
  const Failure(this.e);

  final Exception e;

  String localizedDescription(BuildContext context) {
    return 'Errore generico';
  }
}
