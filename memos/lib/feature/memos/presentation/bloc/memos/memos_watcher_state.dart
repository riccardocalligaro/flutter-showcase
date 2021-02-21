part of 'memos_watcher_bloc.dart';

@immutable
abstract class MemosWatcherState {}

class MemosWatcherInitial extends MemosWatcherState {}

class MemosWatcherLoading extends MemosWatcherState {}

class MemosWatcherLoadSuccess extends MemosWatcherState {
  final MemosPageData memosPageData;

  MemosWatcherLoadSuccess({
    @required this.memosPageData,
  });
}

class MemosWatcherFailure extends MemosWatcherState {
  final Failure failure;

  MemosWatcherFailure({@required this.failure});
}
