import 'package:moor/moor.dart';
import 'package:museo_zuccante/core/data/local/mz_database.dart';
import 'package:museo_zuccante/feature/items/data/models/item_local_model.dart';

part 'items_local_datasource.g.dart';

@UseDao(
  tables: [ItemsTable],
)
class ItemsLocalDatasource extends DatabaseAccessor<MZDatabase>
    with _$ItemsLocalDatasourceMixin {
  ItemsLocalDatasource(MZDatabase db) : super(db);

  Future<List<ItemLocalModel>> getItems() => select(itemsTable).get();

  Future<ItemLocalModel> findItemById(String id) {
    return (select(itemsTable)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<ItemLocalModel>> getRoomItems(String roomId) {
    return (select(itemsTable)..where((t) => t.roomId.equals(roomId))).get();
  }

  Stream<List<ItemLocalModel>> watchAllItems() => select(itemsTable).watch();

  Future<void> insertItem(ItemLocalModel item) =>
      into(itemsTable).insertOnConflictUpdate(item);

  Future<void> insertItems(List<ItemLocalModel> items) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(itemsTable, items);
    });
  }

  Future<void> deleteAllItems() => delete(itemsTable).go();

  Future<void> deleteItems(List<ItemLocalModel> items) async {
    await batch((batch) {
      items.forEach((entry) {
        batch.delete(itemsTable, entry);
      });
    });
  }

  Future<void> bookmarkItem(String id) {
    return customUpdate(
      'UPDATE items SET bookmark ed=1 WHERE id=?',
      variables: [
        Variable.withString(id),
      ],
    );
  }
}
