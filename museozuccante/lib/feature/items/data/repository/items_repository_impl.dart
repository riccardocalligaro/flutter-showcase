import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/local/mz_database.dart';
import 'package:museo_zuccante/core/infrastructure/error/handler.dart';
import 'package:museo_zuccante/core/infrastructure/error/types/failures.dart';
import 'package:museo_zuccante/core/infrastructure/error/types/successes.dart';
import 'package:museo_zuccante/core/data/generics/resource.dart';
import 'package:museo_zuccante/core/infrastructure/network_info.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_local_datasource.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_remote_datasource.dart';
import 'package:museo_zuccante/feature/items/data/models/item_local_model.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  static const String lastUpdateKey = 'itemsLastUpdate';

  final ItemsRemoteDatasource itemsRemoteDatasource;
  final ItemsLocalDatasource itemsLocalDatasource;

  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  ItemsRepositoryImpl({
    @required this.itemsRemoteDatasource,
    @required this.networkInfo,
    @required this.sharedPreferences,
    @required this.itemsLocalDatasource,
  });

  bool _needUpdate() {
    final lastUpdate = sharedPreferences.getInt(lastUpdateKey);
    return lastUpdate == null ||
        DateTime.fromMillisecondsSinceEpoch(lastUpdate)
            .isBefore(DateTime.now().subtract(
          Duration(minutes: 5),
        ));
  }

  @override
  Stream<Resource<List<ItemDomainModel>>> watchAllItems() async* {
    yield* itemsLocalDatasource.watchAllItems().map((localModels) {
      return Resource.success(
          data: localModels
              .map((localModel) => ItemDomainModel.fromLocalModel(localModel))
              .toList());
    }).onErrorReturnWith(
      (e) {
        return Resource.failed(error: e);
      },
    );
  }

  @override
  Future<Either<Failure, Success>> updateItems({bool ifNeeded}) async {
    try {
      if (!ifNeeded | (ifNeeded && _needUpdate())) {
        final remoteItems = await itemsRemoteDatasource.getItems();

        final localItems = await itemsLocalDatasource.getItems();

        // get the ids
        final remoteIds = remoteItems.map((e) => e.id).toList();

        print(remoteIds.toString());

        List<ItemLocalModel> itemsToDelete = [];

        for (final localItem in localItems) {
          if (!remoteIds.contains(localItem.id)) {
            itemsToDelete.add(localItem);
          }
        }

        // await itemsLocalDatasource.deleteAllItems();
        final localI = remoteItems.map(ItemsConverter.fromRemoteModel).toList();

        await itemsLocalDatasource.insertItems(localI);

        // delete the items that were removed from the remote source
        await itemsLocalDatasource.deleteItems(itemsToDelete);

        sharedPreferences.setInt(
            lastUpdateKey, DateTime.now().millisecondsSinceEpoch);

        return Right(SuccessWithUpdate());
      }

      return Right(SuccessWithoutUpdate());
    } catch (e) {
      print(e);
      return Left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, ItemDomainModel>> getItem(String id) async {
    try {
      final item = await itemsLocalDatasource.findItemById(id);

      if (item != null) {
        return Right(ItemDomainModel.fromLocalModel(item));
      } else {
        return Left(ItemNotFoundFailure());
      }
    } catch (e) {
      return Left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<ItemDomainModel>>> getItems() async {
    try {
      final items = await itemsLocalDatasource.getItems();
      return Right(items
          .map(
            (e) => ItemDomainModel.fromLocalModel(e),
          )
          .toList());
    } catch (e) {
      return Left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<ItemDomainModel>>> getRoomItems(
      {String roomId}) async {
    try {
      final items = await itemsLocalDatasource.getRoomItems(roomId);
      return Right(items
          .map(
            (e) => ItemDomainModel.fromLocalModel(e),
          )
          .toList());
    } catch (e) {
      return Left(handleError(e));
    }
  }
}

class ItemNotFoundFailure extends Failure {}
