part of 'share_bloc.dart';

@immutable
abstract class ShareState {}

class ShareInitial extends ShareState {}

class ShareLoading extends ShareState {}

class ShareSuccess extends ShareState {}

class ShareUserNotFound extends ShareState {}

class ShareMemoAlreadyShared extends ShareState {}

class ShareFailure extends ShareState {
  final Failure failure;

  ShareFailure({
    @required this.failure,
  });
}
