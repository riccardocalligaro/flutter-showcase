import 'package:floor/floor.dart';
import 'package:memos/feature/memos/data/model/memo_local_model.dart';

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

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMemos(List<MemoLocalModel> memosLocalModels);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMemo(MemoLocalModel memoLocalModel);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTags(List<TagLocalModel> tags);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMemoTags(List<MemosTags> memosTags);

  @Query('DELETE FROM memos_tags')
  Future<void> deleteAllMemosTags();

  @delete
  Future<void> deleteMemosTags(List<MemosTags> memo);

  @delete
  Future<void> deleteMemo(MemoLocalModel memo);
}
