import 'package:flutter/material.dart';
import 'package:memos/core/infrastructure/failures.dart';
import 'package:memos/core/infrastructure/resource.dart';
import 'package:memos/feature/memos/data/datasource/memos_local_datasource.dart';
import 'package:memos/feature/memos/data/model/memo_local_model.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';
import 'package:memos/feature/memos/domain/repository/memos_repository.dart';
import 'package:rxdart/rxdart.dart';

class MemosRepositoryImpl implements MemosRepository {
  final MemosLocalDatasource memosLocalDatasource;

  MemosRepositoryImpl({
    @required this.memosLocalDatasource,
  });

  @override
  Stream<Resource<MemosPageData>> watchAllMemos() async* {
    yield* Rx.combineLatest3(
      memosLocalDatasource.watchAllMemos(),
      memosLocalDatasource.watchAllTags(),
      memosLocalDatasource.watchAllMemosTags(),
      (
        List<MemoLocalModel> memos,
        List<TagLocalModel> tags,
        List<MemosTags> memosTags,
      ) {
        final domainTags = tags.map((e) => e.toDomainModel()).toList();

        final Map<int, TagDomainModel> tagsMap =
            Map.fromIterable(domainTags, key: (e) => e.id, value: (e) => e);

        List<MemoDomainModel> domainMemos = [];

        for (final memo in memos) {
          final tagsIds = memosTags.where((m) => m.memoId == memo.id);

          List<TagDomainModel> tags = [];

          for (final result in tagsIds) {
            tags.add(tagsMap[result.tagId]);
          }

          domainMemos.add(memo.toDomainModel(tags: tags));
        }

        return Resource.success(
            data: MemosPageData(
          memos: domainMemos,
          tags: domainTags,
        ));
      },
    ).onErrorReturnWith((e) {
      return Resource.failed(error: Failure(e));
    });
  }
}
