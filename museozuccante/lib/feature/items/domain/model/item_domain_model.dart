import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:museo_zuccante/core/data/local/mz_database.dart';
import 'package:museo_zuccante/feature/items/data/models/item_remote_model.dart';

class ItemDomainModel {
  String id;
  String title;
  String subtitle;
  String author;
  String poster;
  String body;
  RoomDomainModel room;
  bool highlighted;
  CompanyDomainModel company;

  ItemDomainModel({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.poster,
    @required this.body,
    @required this.room,
    @required this.highlighted,
    @required this.company,
    @required this.author,
  });

  ItemDomainModel.fromRemoteModel(ItemRemoteModel remote) {
    id = remote.id;
    title = remote.title;
    subtitle = remote.subtitle;
    poster = remote.poster;
    body = remote.body;
    highlighted = remote.highlighted;
    room = RoomDomainModel(
      id: remote.room.id,
      title: remote.room.title,
      floor: remote.room.floor,
      number: remote.room.number,
    );
    company = CompanyDomainModel(
      id: remote.company.id,
      title: remote.company.title,
      poster: remote.company.poster,
      body: remote.company.body,
      stillActive: remote.company.stillActive,
    );
    author = remote.author;
  }

  ItemDomainModel.fromLocalModel(ItemLocalModel local) {
    id = local.id;
    title = local.title;
    subtitle = local.subtitle;
    poster = local.poster;
    body = local.body;
    highlighted = local.highlighted;

    room = RoomDomainModel(
      id: local.roomId,
      number: local.roomNumber,
      floor: local.roomFloor,
      title: local.roomTitle,
    );

    company = CompanyDomainModel(
      id: '',
      title: local.companyTitle,
      poster: local.companyPoster,
      body: local.companyBody,
      stillActive: local.companyStillActive,
    );

    author = local.author;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemDomainModel &&
        o.id == id &&
        o.title == title &&
        o.subtitle == subtitle &&
        o.poster == poster &&
        o.body == body &&
        o.room == room;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        poster.hashCode ^
        body.hashCode ^
        room.hashCode;
  }

  @override
  String toString() {
    return 'ItemDomainModel(id: $id, title: $title, subtitle: $subtitle, poster: $poster, body: $body, room: $room)';
  }
}

class RoomDomainModel {
  String id;
  String title;
  int floor;
  int number;

  RoomDomainModel({
    @required this.id,
    @required this.title,
    @required this.floor,
    @required this.number,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomDomainModel &&
        o.id == id &&
        o.title == title &&
        o.floor == floor &&
        o.number == number;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ floor.hashCode ^ number.hashCode;
  }

  @override
  String toString() {
    return 'RoomDomainModel(id: $id, title: $title, floor: $floor, number: $number)';
  }
}

class CompanyDomainModel {
  String id;
  String title;
  String poster;
  String body;
  bool stillActive;

  CompanyDomainModel({
    @required this.id,
    @required this.title,
    @required this.poster,
    @required this.body,
    @required this.stillActive,
  });

  CompanyDomainModel copyWith({
    String id,
    String title,
    String poster,
    String body,
    bool stillActive,
  }) {
    return CompanyDomainModel(
      id: id ?? this.id,
      title: title ?? this.title,
      poster: poster ?? this.poster,
      body: body ?? this.body,
      stillActive: stillActive ?? this.stillActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster': poster,
      'body': body,
      'stillActive': stillActive,
    };
  }

  factory CompanyDomainModel.fromMap(Map<String, dynamic> map) {
    return CompanyDomainModel(
      id: map['id'],
      title: map['title'],
      poster: map['poster'],
      body: map['body'],
      stillActive: map['stillActive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyDomainModel.fromJson(String source) =>
      CompanyDomainModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CompanyDomainModel(id: $id, title: $title, poster: $poster, body: $body, stillActive: $stillActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyDomainModel &&
        other.id == id &&
        other.title == title &&
        other.poster == poster &&
        other.body == body &&
        other.stillActive == stillActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        poster.hashCode ^
        body.hashCode ^
        stillActive.hashCode;
  }
}
