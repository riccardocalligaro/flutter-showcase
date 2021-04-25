import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/local/mz_database.dart';
import 'package:museo_zuccante/feature/rooms/data/models/room_remote_model.dart';

class RoomDomainModel {
  String id;
  String title;
  int floor;
  int number;
  double offsetX;
  double offsetY;

  RoomDomainModel({
    @required this.id,
    @required this.title,
    @required this.floor,
    @required this.number,
    @required this.offsetX,
    @required this.offsetY,
  });

  RoomDomainModel.fromRemoteModel(RoomRemoteModel roomRemoteModel) {
    id = roomRemoteModel.id;
    title = roomRemoteModel.title;
    floor = roomRemoteModel.floor;
    number = roomRemoteModel.number;
    offsetX = roomRemoteModel.pixelX;
    offsetY = roomRemoteModel.pixelY;
  }

  RoomDomainModel.fromLocalModel(RoomLocalModel roomLocalModel) {
    id = roomLocalModel.id;
    title = roomLocalModel.title;
    floor = roomLocalModel.floor;
    number = roomLocalModel.number;
    offsetX = roomLocalModel.offsetX;
    offsetY = roomLocalModel.offsetY;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomDomainModel &&
        o.id == id &&
        o.title == title &&
        o.floor == floor &&
        o.number == number &&
        o.offsetX == offsetX &&
        o.offsetY == offsetY;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        floor.hashCode ^
        number.hashCode ^
        offsetX.hashCode ^
        offsetY.hashCode;
  }

  @override
  String toString() {
    return 'RoomDomainModel(id: $id, title: $title, floor: $floor, number: $number, offsetX: $offsetX, offsetY: $offsetY)';
  }
}
