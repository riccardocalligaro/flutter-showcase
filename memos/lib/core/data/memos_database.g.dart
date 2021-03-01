// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memos_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorMemosDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MemosDatabaseBuilder databaseBuilder(String name) =>
      _$MemosDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MemosDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$MemosDatabaseBuilder(null);
}

class _$MemosDatabaseBuilder {
  _$MemosDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$MemosDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MemosDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MemosDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$MemosDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MemosDatabase extends MemosDatabase {
  _$MemosDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MemosLocalDatasource _memosLocalDatasourceInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `memos` (`id` TEXT, `title` TEXT, `content` TEXT, `color` TEXT, `state` TEXT, `creator` TEXT, `created_at` INTEGER, `remind_at` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tags` (`id` TEXT, `title` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `memos_tags` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `memo_id` TEXT, `tag_id` TEXT, FOREIGN KEY (`memo_id`) REFERENCES `memos` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MemosLocalDatasource get memosLocalDatasource {
    return _memosLocalDatasourceInstance ??=
        _$MemosLocalDatasource(database, changeListener);
  }
}

class _$MemosLocalDatasource extends MemosLocalDatasource {
  _$MemosLocalDatasource(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _memoLocalModelInsertionAdapter = InsertionAdapter(
            database,
            'memos',
            (MemoLocalModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'color': item.color,
                  'state': item.state,
                  'creator': item.creator,
                  'created_at': _dateTimeConverter.encode(item.createdAt),
                  'remind_at': _dateTimeConverter.encode(item.remindAt)
                },
            changeListener),
        _tagLocalModelInsertionAdapter = InsertionAdapter(
            database,
            'tags',
            (TagLocalModel item) =>
                <String, dynamic>{'id': item.id, 'title': item.title},
            changeListener),
        _memosTagsInsertionAdapter = InsertionAdapter(
            database,
            'memos_tags',
            (MemosTags item) => <String, dynamic>{
                  'id': item.id,
                  'memo_id': item.memoId,
                  'tag_id': item.tagId
                },
            changeListener),
        _memoLocalModelUpdateAdapter = UpdateAdapter(
            database,
            'memos',
            ['id'],
            (MemoLocalModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'color': item.color,
                  'state': item.state,
                  'creator': item.creator,
                  'created_at': _dateTimeConverter.encode(item.createdAt),
                  'remind_at': _dateTimeConverter.encode(item.remindAt)
                },
            changeListener),
        _memosTagsDeletionAdapter = DeletionAdapter(
            database,
            'memos_tags',
            ['id'],
            (MemosTags item) => <String, dynamic>{
                  'id': item.id,
                  'memo_id': item.memoId,
                  'tag_id': item.tagId
                },
            changeListener),
        _memoLocalModelDeletionAdapter = DeletionAdapter(
            database,
            'memos',
            ['id'],
            (MemoLocalModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'color': item.color,
                  'state': item.state,
                  'creator': item.creator,
                  'created_at': _dateTimeConverter.encode(item.createdAt),
                  'remind_at': _dateTimeConverter.encode(item.remindAt)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MemoLocalModel> _memoLocalModelInsertionAdapter;

  final InsertionAdapter<TagLocalModel> _tagLocalModelInsertionAdapter;

  final InsertionAdapter<MemosTags> _memosTagsInsertionAdapter;

  final UpdateAdapter<MemoLocalModel> _memoLocalModelUpdateAdapter;

  final DeletionAdapter<MemosTags> _memosTagsDeletionAdapter;

  final DeletionAdapter<MemoLocalModel> _memoLocalModelDeletionAdapter;

  @override
  Stream<List<MemoLocalModel>> watchAllMemos() {
    return _queryAdapter.queryListStream('SELECT * FROM memos',
        queryableName: 'memos',
        isView: false,
        mapper: (Map<String, dynamic> row) => MemoLocalModel(
            id: row['id'] as String,
            title: row['title'] as String,
            content: row['content'] as String,
            color: row['color'] as String,
            state: row['state'] as String,
            createdAt: _dateTimeConverter.decode(row['created_at'] as int),
            remindAt: _dateTimeConverter.decode(row['remind_at'] as int),
            creator: row['creator'] as String));
  }

  @override
  Stream<List<MemosTags>> watchAllMemosTags() {
    return _queryAdapter.queryListStream('SELECT * FROM memos_tags',
        queryableName: 'memos_tags',
        isView: false,
        mapper: (Map<String, dynamic> row) => MemosTags(
            id: row['id'] as int,
            memoId: row['memo_id'] as String,
            tagId: row['tag_id'] as String));
  }

  @override
  Stream<List<MemosTags>> watchAllMemosTagsForMemo(String id) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM memos_tags WHERE memo_id = ?',
        arguments: <dynamic>[id],
        queryableName: 'memos_tags',
        isView: false,
        mapper: (Map<String, dynamic> row) => MemosTags(
            id: row['id'] as int,
            memoId: row['memo_id'] as String,
            tagId: row['tag_id'] as String));
  }

  @override
  Future<List<MemosTags>> getMemosTagsForMemo(String id) async {
    return _queryAdapter.queryList('SELECT * FROM memos_tags WHERE memo_id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => MemosTags(
            id: row['id'] as int,
            memoId: row['memo_id'] as String,
            tagId: row['tag_id'] as String));
  }

  @override
  Future<void> deleteTagsForMemo(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM memos_tags WHERE memo_id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Stream<List<TagLocalModel>> watchAllTags() {
    return _queryAdapter.queryListStream('SELECT * FROM tags',
        queryableName: 'tags',
        isView: false,
        mapper: (Map<String, dynamic> row) => TagLocalModel(
            id: row['id'] as String, title: row['title'] as String));
  }

  @override
  Future<void> deleteAllMemosTags() async {
    await _queryAdapter.queryNoReturn('DELETE FROM memos_tags');
  }

  @override
  Future<void> insertMemos(List<MemoLocalModel> memosLocalModels) async {
    await _memoLocalModelInsertionAdapter.insertList(
        memosLocalModels, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertMemo(MemoLocalModel memoLocalModel) async {
    await _memoLocalModelInsertionAdapter.insert(
        memoLocalModel, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertTags(List<TagLocalModel> tags) async {
    await _tagLocalModelInsertionAdapter.insertList(
        tags, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertMemoTags(List<MemosTags> memosTags) async {
    await _memosTagsInsertionAdapter.insertList(
        memosTags, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateMemo(MemoLocalModel memoLocalModel) async {
    await _memoLocalModelUpdateAdapter.update(
        memoLocalModel, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMemosTags(List<MemosTags> memo) async {
    await _memosTagsDeletionAdapter.deleteList(memo);
  }

  @override
  Future<void> deleteMemo(MemoLocalModel memo) async {
    await _memoLocalModelDeletionAdapter.delete(memo);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
