part of 'share_bloc.dart';

@immutable
abstract class ShareEvent {}

class ResetShare extends ShareEvent {}

class ShareMemo extends ShareEvent {
  final String email;
  final String memoId;

  ShareMemo(
    this.email,
    this.memoId,
  );
}
