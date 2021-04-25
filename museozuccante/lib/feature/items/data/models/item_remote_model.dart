import 'package:museo_zuccante/feature/rooms/data/models/room_remote_model.dart';

class ItemRemoteModel {
  String title;
  String subtitle;
  String poster;
  String body;
  String author;
  bool highlighted;
  RoomRemoteModel room;
  CompanyRemoteModel company;
  String id;

  ItemRemoteModel({
    this.title,
    this.subtitle,
    this.poster,
    this.body,
    this.room,
    this.id,
    this.highlighted,
    this.author,
  });

  ItemRemoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    poster = json['poster'];
    body = json['body'];
    author = json['author'];
    room = json['room'] != null ? RoomRemoteModel.fromJson(json['room']) : null;
    id = json['id'];
    highlighted = json['highlighted'];
    company = json['company'] != null
        ? CompanyRemoteModel.fromJson(json['company'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['poster'] = poster;
    data['body'] = body;
    data['author'] = author;
    if (room != null) {
      data['room'] = room.toJson();
    }
    if (company != null) {
      data['company'] = company.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class CompanyRemoteModel {
  String title;
  String poster;
  bool stillActive;
  String body;
  String id;

  CompanyRemoteModel(
      {this.title, this.poster, this.stillActive, this.body, this.id});

  CompanyRemoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    poster = json['poster'];
    stillActive = json['still_active'];
    body = json['body'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['poster'] = poster;
    data['still_active'] = stillActive;
    data['body'] = body;
    data['id'] = id;
    return data;
  }
}
