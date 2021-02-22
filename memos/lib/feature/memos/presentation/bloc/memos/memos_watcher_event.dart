part of 'memos_watcher_bloc.dart';

@immutable
abstract class MemosWatcherEvent {}

class MemosDataReceived extends MemosWatcherEvent {
  final Resource<MemosPageData> resource;

  MemosDataReceived({
    @required this.resource,
  });
}

class FilterMemos extends MemosWatcherEvent {
  final MemoState filter;
  final TagDomainModel tag;

  FilterMemos({
    this.filter,
    this.tag,
  });
}
