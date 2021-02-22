import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:memos/core/infrastructure/error_handler.dart';
import 'package:memos/core/infrastructure/failures.dart';
import 'package:memos/core/infrastructure/resource.dart';
import 'package:memos/feature/memos/data/datasource/memos_local_datasource.dart';
import 'package:memos/feature/memos/data/model/memo_local_model.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';
import 'package:memos/feature/memos/domain/repository/memos_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class MemosRepositoryImpl implements MemosRepository {
  final MemosLocalDatasource memosLocalDatasource;

  MemosRepositoryImpl({
    @required this.memosLocalDatasource,
  });

  @override
  Stream<Resource<MemosPageData>> watchAllMemos(
    MemoState filter,
    TagDomainModel tag,
  ) async* {
    yield* Rx.combineLatest3(
      memosLocalDatasource.watchAllMemos(),
      memosLocalDatasource.watchAllTags(),
      memosLocalDatasource.watchAllMemosTags(),
      (
        List<MemoLocalModel> memos,
        List<TagLocalModel> tags,
        List<MemosTags> memosTags,
      ) {
        final domainTags = tags
            .map(
              (e) => e.toDomainModel(
                memosTags.where((m) => m.tagId == e.id).length,
              ),
            )
            .toList();

        domainTags.sort((b, a) => a.count.compareTo(b.count));

        final Map<String, TagDomainModel> tagsMap = Map.fromIterable(
          domainTags,
          key: (e) => e.id,
          value: (e) => e,
        );

        List<MemoDomainModel> domainMemos = [];

        for (final memo in memos) {
          final tagsIds = memosTags.where((m) => m.memoId == memo.id);

          List<TagDomainModel> tags = [];

          for (final result in tagsIds) {
            tags.add(tagsMap[result.tagId]);
          }

          domainMemos.add(memo.toDomainModel(tags: tags));
        }

        domainMemos.sort((b, a) => a.createdAt.compareTo(b.createdAt));

        if (filter != null && filter != MemoState.all) {
          domainMemos = domainMemos.where((e) => e.state == filter).toList();
        }

        if (tag != null) {
          domainMemos = domainMemos
              .where((e) => e.tags.map((e) => e.id).contains(tag.id))
              .toList();
        }

        return Resource.success(
            data: MemosPageData(
          memos: domainMemos,
          tags: domainTags,
        ));
      },
    ).onErrorReturnWith((e) {
      print(e);
      return Resource.failed(error: Failure(Exception(e)));
    });
  }

  @override
  Future<Either<Failure, Success>> insertMemo(MemoDomainModel memo) async {
    try {
      final tags = memo.tags;

      final localModel = memo.toLocalModel();

      List<TagLocalModel> localTags = [];
      List<TagLocalModel> localTagsToAdd = [];

      for (final tag in tags) {
        if (tag.id.isEmpty) {
          // è necessario aggiungerli al db
          final newTag = TagLocalModel(
            id: Uuid().v4(),
            title: tag.title,
          );

          localTagsToAdd.add(newTag);
          localTags.add(newTag);
        } else {
          localTags.add(tag.toLocalModel());
        }
      }

      await memosLocalDatasource.insertTags(localTagsToAdd);

      List<MemosTags> memosTags = [];

      for (final localTag in localTags) {
        memosTags.add(
          MemosTags(
            id: null,
            memoId: memo.id,
            tagId: localTag.id,
          ),
        );
      }

      await memosLocalDatasource.insertMemo(localModel);

      await memosLocalDatasource.insertMemoTags(memosTags);

      return Right(Success());
    } catch (e) {
      print(e);
      return Left(Failure(Exception(e)));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteMemo(MemoDomainModel memo) async {
    try {
      await memosLocalDatasource.deleteTagsForMemo(memo.id);
      await memosLocalDatasource.deleteMemo(memo.toLocalModel());
      return Right(Success());
    } catch (e, s) {
      return Left(handleError(e, s));
    }
  }
}
