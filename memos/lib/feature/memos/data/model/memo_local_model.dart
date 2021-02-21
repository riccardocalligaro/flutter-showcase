import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';

@Entity(tableName: 'memos')
class MemoLocalModel {
  @primaryKey
  final String id;
  final String title;
  final String content;
  final String color;
  final String state;

  final String creator;

  @ColumnInfo(name: 'created_at')
  final DateTime createdAt;

  @ColumnInfo(name: 'remind_at')
  final DateTime remindAt;

  MemoLocalModel({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.color,
    @required this.state,
    @required this.createdAt,
    @required this.remindAt,
    @required this.creator,
  });

  MemoDomainModel toDomainModel({
    @required List<TagDomainModel> tags,
  }) {
    return MemoDomainModel(
      id: id,
      title: title,
      content: content,
      color: Color(hexToInt(color)),
      state: MemoState.values.firstWhere((str) => str.toString() == state),
      createdAt: createdAt,
      remindAt: remindAt,
      tags: tags,
    );
  }

  int hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }
}

@Entity(tableName: 'memos_tags', foreignKeys: [
  ForeignKey(
    childColumns: ['memo_id'],
    parentColumns: ['id'],
    entity: MemoLocalModel,
  ),
  ForeignKey(
    childColumns: ['tag_id'],
    parentColumns: ['id'],
    entity: TagLocalModel,
  )
])
class MemosTags {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'memo_id')
  final String memoId;
  @ColumnInfo(name: 'tag_id')
  final String tagId;

  MemosTags({
    @required this.id,
    @required this.memoId,
    @required this.tagId,
  });
}

@Entity(tableName: 'tags')
class TagLocalModel {
  @primaryKey
  final String id;
  final String title;

  TagLocalModel({
    @required this.id,
    @required this.title,
  });

  TagDomainModel toDomainModel() {
    return TagDomainModel(
      id: id,
      title: title,
    );
  }
}
