import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:memos/core/infrastructure/failures.dart';
import 'package:memos/core/infrastructure/resource.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';
import 'package:memos/feature/memos/domain/repository/memos_repository.dart';
import 'package:meta/meta.dart';

part 'memos_watcher_event.dart';
part 'memos_watcher_state.dart';

class MemosWatcherBloc extends Bloc<MemosWatcherEvent, MemosWatcherState> {
  final MemosRepository memosRepository;

  StreamSubscription _memosStreamSubscription;

  MemosWatcherBloc({
    @required this.memosRepository,
  }) : super(MemosWatcherInitial()) {
    _memosStreamSubscription =
        memosRepository.watchAllMemos().listen((resource) {
      add(MemosDataReceived(resource: resource));
    });
  }

  @override
  Stream<MemosWatcherState> mapEventToState(
    MemosWatcherEvent event,
  ) async* {
    if (event is MemosDataReceived) {
      if (event.resource.status == Status.failed) {
        yield MemosWatcherFailure(failure: event.resource.failure);
      } else if (event.resource.status == Status.success) {
        yield MemosWatcherLoadSuccess(
          memosPageData: event.resource.data,
        );
      } else if (event.resource.status == Status.loading) {
        yield MemosWatcherLoading();
      }
    }
  }

  @override
  Future<void> close() {
    _memosStreamSubscription.cancel();
    return super.close();
  }
}
