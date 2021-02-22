import 'package:floor/floor.dart';
import 'package:memos/feature/memos/data/model/memo_local_model.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';

@dao
abstract class MemosLocalDatasource {
  @Query('SELECT * FROM memos')
  Stream<List<MemoLocalModel>> watchAllMemos();

  @Query('SELECT * FROM memos_tags')
  Stream<List<MemosTags>> watchAllMemosTags();

  @Query('SELECT * FROM memos_tags WHERE memo_id = :id')
  Stream<List<MemosTags>> watchAllMemosTagsForMemo(String id);

  @Query('SELECT * FROM memos_tags WHERE memo_id = :id')
  Future<List<MemosTags>> getMemosTagsForMemo(String id);

  @Query('DELETE FROM memos_tags WHERE memo_id = :id')
  Future<void> deleteTagsForMemo(String id);

  @Query('SELECT * FROM tags')
  Stream<List<TagLocalModel>> watchAllTags();

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMemo(MemoLocalModel memoLocalModel);

  @insert
  Future<void> insertMemo(MemoLocalModel memoLocalModel);

  @insert
  Future<void> insertTags(List<TagLocalModel> tags);

  @insert
  Future<void> insertMemoTags(List<MemosTags> memosTags);

  @delete
  Future<void> deleteMemosTags(List<MemosTags> memo);

  @delete
  Future<void> deleteMemo(MemoLocalModel memo);
}
