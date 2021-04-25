import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/presentation/styles.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast _fToast;
BuildContext _mainContext;
BuildContext get mainContext => _mainContext;

/// Someone needs to call this so our Commands can access models and services. Usually main_view.dart
void setContext(BuildContext c) {
  _mainContext = c;
  if (_fToast == null) {
    _fToast = FToast();
    _fToast.init(_mainContext);
  }
}

class BaseAppCommand {
  /// Provide quick lookups for the main Models and Services in the App.
  T getProvided<T>() {
    assert(_mainContext != null,
        "You must call AbstractCommand.init(BuildContext) method before calling Commands.");
    return _mainContext.read<T>();
  }

  void showToast(String content, {bool allowQueue = false}) {
    TextStyle textStyle = TextStyles.caption.copyWith();
    if (allowQueue == false) _fToast.removeQueuedCustomToasts();
    _fToast.showToast(
      toastDuration: Duration(milliseconds: 1500),
      gravity: ToastGravity.TOP,
      child: Container(
        padding: EdgeInsets.only(top: Insets.offset),
        child: Container(
          decoration: BoxDecoration(
            // color: appModel.theme.greyStrong,
            borderRadius: Corners.medBorder,
          ),
          padding: EdgeInsets.all(Insets.sm),
          child: Text(content, style: textStyle),
        ),
      ),
    );
  }
}
