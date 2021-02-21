part of 'memos_watcher_bloc.dart';

@immutable
abstract class MemosWatcherEvent {}

class MemosDataReceived extends MemosWatcherEvent {
  final Resource<MemosPageData> resource;

  MemosDataReceived({
    @required this.resource,
  });
}
