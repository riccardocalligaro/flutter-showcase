import 'package:flutter/material.dart';

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

  MemoDomainModel({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.color,
    @required this.state,
    @required this.createdAt,
    @required this.remindAt,
    @required this.tags,
  });
}

enum MemoState { deleted, archived, pinned, unspecified, shared }

class TagDomainModel {
  final String id;
  String title;

  TagDomainModel({
    @required this.id,
    @required this.title,
  });
}
