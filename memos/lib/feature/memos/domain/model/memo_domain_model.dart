import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color?.value,
      'state': state?.toString(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'remindAt': remindAt?.millisecondsSinceEpoch,
      'tags': tags?.map((x) => x?.toMap())?.toList(),
      'creator': creator,
    };
  }

  factory MemoDomainModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MemoDomainModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      color: Color(map['color']),
      state: MemoState.values.firstWhere(
        (str) => str.toString() == map['state'],
        orElse: () => MemoState.all,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      remindAt: DateTime.fromMillisecondsSinceEpoch(map['remindAt']),
      tags: List<TagDomainModel>.from(
          map['tags']?.map((x) => TagDomainModel.fromMap(x))),
      creator: map['creator'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MemoDomainModel.fromJson(String source) =>
      MemoDomainModel.fromMap(json.decode(source));
}

enum MemoState { all, shared, archived, pinned }

class TagDomainModel {
  final String id;
  String title;
  int count;

  TagDomainModel({
    @required this.id,
    @required this.title,
    @required this.count,
  });

  TagLocalModel toLocalModel() {
    return TagLocalModel(
      id: id,
      title: title,
    );
  }

  @override
  String toString() => 'TagDomainModel(id: $id, title: $title)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'count': count,
    };
  }

  factory TagDomainModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TagDomainModel(
      id: map['id'],
      title: map['title'],
      count: map['count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TagDomainModel.fromJson(String source) =>
      TagDomainModel.fromMap(json.decode(source));
}
