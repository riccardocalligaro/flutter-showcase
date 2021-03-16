import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:memos/core/infrastructure/failures.dart';
import 'package:memos/feature/memos/data/repository/memos_repository_impl.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';
import 'package:memos/feature/memos/domain/repository/memos_repository.dart';
import 'package:meta/meta.dart';

part 'share_event.dart';
part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final MemosRepository memosRepository;

  ShareBloc({
    @required this.memosRepository,
  }) : super(ShareInitial());

  @override
  Stream<ShareState> mapEventToState(
    ShareEvent event,
  ) async* {
    if (event is ResetShare) {
      yield ShareInitial();
    } else if (event is ShareMemo) {
      yield ShareLoading();
      final shareResponse = await memosRepository.shareMemo(
        event.memoId,
        event.email,
        event.memo,
      );

      yield* shareResponse.fold((failure) async* {
        if (failure is EmailNotCorrectFailure) {
          yield ShareUserNotFound();
        } else if (failure is MemoAlreadyShared) {
          yield ShareMemoAlreadyShared();
        } else {
          yield ShareFailure(failure: failure);
        }
      }, (medics) async* {
        yield ShareSuccess();
      });
    }
  }
}
