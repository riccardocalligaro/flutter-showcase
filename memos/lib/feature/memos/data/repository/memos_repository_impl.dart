import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

      await FirebaseFirestore.instance
          .collection('memos')
          .doc(memo.id)
          .set(memo.toMap());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update(
        {
          'memos': FieldValue.arrayUnion(
            [
              memo.id,
            ],
          ),
        },
      );

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

      await FirebaseFirestore.instance
          .collection('memos')
          .doc(memo.id)
          .delete();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update(
        {
          'memos': FieldValue.arrayRemove(
            [memo.id],
          ),
        },
      );

      return Right(Success());
    } catch (e, s) {
      return Left(handleError(e, s));
    }
  }

  @override
  Future<Either<Failure, Success>> shareMemo(String id, String email) async {
    try {
      final userIdToShare = (await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get())
          .docs;

      if (userIdToShare.length == 1) {
        final userMemos = userIdToShare.first.data()['memos'] as List<dynamic>;
        if (userMemos.contains(id)) {
          return Left(MemoAlreadyShared());
        }
        // allora abbiamo un utente
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userIdToShare.first.id)
            .update({
          'memos': FieldValue.arrayUnion([
            id,
          ])
        });
      } else {
        return Left(EmailNotCorrectFailure());
      }

      return Right(Success());
    } catch (e, s) {
      return Left(handleError(e, s));
    }
  }

  @override
  Future<Either<Failure, Success>> syncWithRemote() async {
    try {
      // otteniamo gli id delle memo dell'utente
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get();

      // tutti gli id delle memo dell'utente
      final List memoIds = userSnapshot.data()['memos'];

      final memosSnapshot =
          await FirebaseFirestore.instance.collection('memos').get();

      List<MemoDomainModel> domainMemos = [];

      for (final memoDocument in memosSnapshot.docs) {
        if (memoIds.contains(memoDocument.id)) {
          domainMemos.add(MemoDomainModel.fromMap(memoDocument.data()));
        }
      }

      List<TagLocalModel> tagsToAdd = [];
      List<MemoLocalModel> memosToAdd = [];
      List<MemosTags> memosTagsToAdd = [];

      for (final memo in domainMemos) {
        final tags = memo.tags;
        print(tags);

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

        tagsToAdd.addAll(localTagsToAdd);

        List<MemosTags> memosTags = [];

        await memosLocalDatasource.deleteAllMemosTags();

        for (final localTag in localTags) {
          memosTags.add(
            MemosTags(
              id: null,
              memoId: memo.id,
              tagId: localTag.id,
            ),
          );
        }

        memosToAdd.add(localModel);
        memosTagsToAdd.addAll(memosTags);
      }

      // ora che abbiamo le memo dobbiamo aggiungerle al db corrente
      await memosLocalDatasource.insertMemos(memosToAdd);
      await memosLocalDatasource.insertMemoTags(memosTagsToAdd);
      await memosLocalDatasource.insertTags(tagsToAdd);

      return Right(Success());
    } catch (e, s) {
      return Left(handleError(e, s));
    }
  }
}

class EmailNotCorrectFailure extends Failure {
  EmailNotCorrectFailure() : super(null);
}

class MemoAlreadyShared extends Failure {
  MemoAlreadyShared() : super(null);
}
