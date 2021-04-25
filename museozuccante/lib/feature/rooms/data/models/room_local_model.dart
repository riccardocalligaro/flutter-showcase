import 'package:moor/moor.dart';
import 'package:museo_zuccante/core/data/local/mz_database.dart';
import 'package:museo_zuccante/feature/rooms/data/models/room_remote_model.dart';

@DataClassName('RoomLocalModel')
class RoomsTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get floor => integer()();
  IntColumn get number => integer()();
  RealColumn get offsetX => real().nullable()();
  RealColumn get offsetY => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class RoomsConverter {
  static RoomLocalModel fromRemoteModel(RoomRemoteModel r) {
    return RoomLocalModel(
      id: r.id,
      title: r.title,
      floor: r.floor,
      number: r.number,
      offsetX: r.pixelX,
      offsetY: r.pixelY,
    );
  }
}
