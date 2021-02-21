import 'package:flutter/foundation.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';

/// Holds the current searching filter of notes.
class MemoFilter extends ChangeNotifier {
  MemoState _memoState;

  MemoState get memoState => _memoState;
  set memoState(MemoState value) {
    if (value != null && value != _memoState) {
      _memoState = value;
      notifyListeners();
    }
  }

  MemoFilter([this._memoState = MemoState.unspecified]);
}
