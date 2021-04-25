import 'package:museo_zuccante/core/data/local/mz_database.dart';
import 'package:museo_zuccante/feature/rooms/data/models/room_local_model.dart';
import 'package:moor/moor.dart';

part 'rooms_local_datasource.g.dart';

@UseDao(
  tables: [RoomsTable],
)
class RoomsLocalDatasource extends DatabaseAccessor<MZDatabase>
    with _$RoomsLocalDatasourceMixin {
  RoomsLocalDatasource(MZDatabase db) : super(db);
  Future<List<RoomLocalModel>> getRooms() => select(roomsTable).get();

  Future<RoomLocalModel> findRoomById(String id) {
    return (select(roomsTable)..where((t) => t.id.equals(id))).getSingle();
  }

  Stream<List<RoomLocalModel>> watchAllRooms() => select(roomsTable).watch();

  Future<void> insertRoom(RoomLocalModel room) =>
      into(roomsTable).insertOnConflictUpdate(room);

  Future<void> insertRooms(List<RoomLocalModel> rooms) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(roomsTable, rooms);
    });
  }

  Future<void> deleteAllRooms() => delete(roomsTable).go();

  Future<void> deleteRooms(List<RoomLocalModel> rooms) async {
    await batch((batch) {
      rooms.forEach((entry) {
        batch.delete(roomsTable, entry);
      });
    });
  }
}
