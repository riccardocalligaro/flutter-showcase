import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:museo_zuccante/core/data/generics/resource.dart';
import 'package:museo_zuccante/core/data/local/mz_database.dart';
import 'package:museo_zuccante/core/infrastructure/error/handler.dart';
import 'package:museo_zuccante/core/infrastructure/error/types/failures.dart';
import 'package:museo_zuccante/core/infrastructure/error/types/successes.dart';
import 'package:museo_zuccante/core/infrastructure/network_info.dart';
import 'package:museo_zuccante/feature/rooms/data/datasources/rooms_local_datasource.dart';
import 'package:museo_zuccante/feature/rooms/data/datasources/rooms_remote_datasource.dart';
import 'package:museo_zuccante/feature/rooms/data/models/room_local_model.dart';
import 'package:museo_zuccante/feature/rooms/domain/model/room_domain_model.dart';
import 'package:museo_zuccante/feature/rooms/domain/repository/rooms_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class RoomsRepositoryImpl extends RoomsRepository {
  static const String lastUpdateKey = 'roomsLastUpdate';

  final RoomsRemoteDatasource roomsRemoteDatasource;
  final RoomsLocalDatasource roomsLocalDatasource;

  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  RoomsRepositoryImpl({
    @required this.roomsRemoteDatasource,
    @required this.networkInfo,
    @required this.sharedPreferences,
    @required this.roomsLocalDatasource,
  });

  @override
  Stream<Resource<List<RoomDomainModel>>> watchAllRooms() async* {
    yield* roomsLocalDatasource.watchAllRooms().map((localModels) {
      print("");
      return Resource.success(
          data: localModels
              .map((localModel) => RoomDomainModel.fromLocalModel(localModel))
              .toList());
    }).onErrorReturnWith(
      (e) {
        return Resource.failed(error: e);
      },
    );
  }

  bool _needUpdate() {
    final lastUpdate = sharedPreferences.getInt(lastUpdateKey);
    return lastUpdate == null ||
        DateTime.fromMillisecondsSinceEpoch(lastUpdate)
            .isBefore(DateTime.now().subtract(
          Duration(minutes: 10),
        ));
  }

  @override
  Future<Either<Failure, Success>> updateRooms({bool ifNeeded}) async {
    if (await networkInfo.isConnected) {
      try {
        if (!ifNeeded | (ifNeeded && _needUpdate())) {
          // await roomsLocalDatasource.deleteAllRooms();

          // return Right(Success());
          final remoteRooms = await roomsRemoteDatasource.getRooms();
          // print("local" + remoteRooms.map((e) => e.toString()).toString());

          final localRooms = await roomsLocalDatasource.getRooms();
          // print("local" + localRooms.map((e) => e.toString()).toString());
          // get the ids
          final remoteIds = remoteRooms.map((e) => e.id).toList();

          List<RoomLocalModel> roomsToDelete = [];

          for (final localRoom in localRooms) {
            if (!remoteIds.contains(localRoom.id)) {
              roomsToDelete.add(localRoom);
            }
          }

          await roomsLocalDatasource.insertRooms(
            remoteRooms.map(RoomsConverter.fromRemoteModel).toList(),
          );

          // delete the rooms that were removed from the remote source
          await roomsLocalDatasource.deleteRooms(roomsToDelete);

          sharedPreferences.setInt(
              lastUpdateKey, DateTime.now().millisecondsSinceEpoch);

          return Right(SuccessWithUpdate());
        }

        return Right(SuccessWithoutUpdate());
      } catch (e) {
        return Left(handleError(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
