import 'package:moor/moor.dart';
import 'package:museo_zuccante/core/data/local/mz_database.dart';
import 'package:museo_zuccante/feature/items/data/models/item_remote_model.dart';

@DataClassName('ItemLocalModel')
class ItemsTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get subtitle => text()();
  TextColumn get poster => text()();
  TextColumn get body => text()();
  BoolColumn get highlighted => boolean()();
  TextColumn get roomId => text()();
  TextColumn get roomTitle => text()();
  IntColumn get roomFloor => integer()();
  IntColumn get roomNumber => integer()();
  TextColumn get companyTitle => text()();
  TextColumn get companyPoster => text()();
  BoolColumn get companyStillActive => boolean()();
  TextColumn get companyBody => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class ItemsConverter {
  static ItemLocalModel fromRemoteModel(ItemRemoteModel remote) {
    return ItemLocalModel(
      id: remote.id,
      author: remote.author,
      title: remote.title,
      subtitle: remote.subtitle,
      poster: remote.poster,
      body: remote.body,
      highlighted: remote.highlighted,
      roomId: remote.room.id,
      roomTitle: remote.room.title,
      roomFloor: remote.room.floor,
      roomNumber: remote.room.number,
      companyTitle: remote.company.title,
      companyBody: remote.company.body,
      companyPoster: remote.company.poster,
      companyStillActive: remote.company.stillActive,
    );
  }
}
