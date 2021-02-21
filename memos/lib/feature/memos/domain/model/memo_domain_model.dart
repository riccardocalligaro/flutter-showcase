import 'package:flutter/material.dart';
import 'package:memos/feature/memos/data/model/memo_local_model.dart';

class MemosPageData {
  List<MemoDomainModel> memos;
  List<TagDomainModel> tags;

  MemosPageData({
    @required this.memos,
    @required this.tags,
  });
}

class MemoDomainModel {
  final String id;
  String title;
  String content;
  Color color;
  MemoState state;
  DateTime createdAt;
  DateTime remindAt;
  List<TagDomainModel> tags;
  String creator;

  MemoDomainModel({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.color,
    @required this.state,
    @required this.createdAt,
    @required this.remindAt,
    @required this.tags,
    @required this.creator,
  });

  MemoLocalModel toLocalModel() {
    return MemoLocalModel(
      id: id,
      title: title,
      content: content,
      color: 'ffff',
      state: state.toString(),
      createdAt: createdAt,
      remindAt: remindAt,
      creator: creator,
    );
  }
}

enum MemoState { deleted, archived, pinned, all, shared }

class TagDomainModel {
  final String id;
  String title;

  TagDomainModel({
    @required this.id,
    @required this.title,
  });

  TagLocalModel toLocalModel() {
    return TagLocalModel(
      id: id,
      title: title,
    );
  }
}
