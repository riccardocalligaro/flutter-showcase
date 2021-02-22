import 'dart:async';

import 'package:floor/floor.dart';
import 'package:memos/feature/memos/data/datasource/memos_local_datasource.dart';
import 'package:memos/feature/memos/data/model/memo_local_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'date_time_type_converter.dart';

part 'memos_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [
  MemoLocalModel,
  TagLocalModel,
  MemosTags,
])
abstract class MemosDatabase extends FloorDatabase {
  MemosLocalDatasource get memosLocalDatasource;

  Future<void> clearAllTables() async {
    await database.execute('DELETE FROM memos_tags');
    await database.execute('DELETE FROM tags');
    await database.execute('DELETE FROM memos');
  }
}
