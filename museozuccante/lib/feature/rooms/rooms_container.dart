import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:museo_zuccante/feature/rooms/data/datasources/rooms_local_datasource.dart';
import 'package:museo_zuccante/feature/rooms/domain/usecase/get_items_for_room_usecase.dart';
import 'package:museo_zuccante/feature/rooms/presentation/single/bloc/room_items_bloc.dart';
import 'package:museo_zuccante/feature/rooms/presentation/updater/rooms_updater_bloc.dart';
import 'package:museo_zuccante/feature/rooms/presentation/watcher/rooms_watcher_bloc.dart';

import 'data/datasources/rooms_remote_datasource.dart';
import 'data/repository/rooms_repository_impl.dart';
import 'domain/repository/rooms_repository.dart';
import 'domain/usecase/update_rooms_usecase.dart';
import 'domain/usecase/watch_rooms_usecase.dart';

final _sl = GetIt.instance;

class RoomsContainer {
  static Future<void> init() async {
    _sl.registerLazySingleton(() => RoomsRemoteDatasource(dio: _sl()));

    _sl.registerLazySingleton(() => RoomsLocalDatasource(_sl()));

    _sl.registerLazySingleton<RoomsRepository>(
      () => RoomsRepositoryImpl(
        networkInfo: _sl(),
        roomsRemoteDatasource: _sl(),
        roomsLocalDatasource: _sl(),
        sharedPreferences: _sl(),
      ),
    );

    _sl.registerLazySingleton(
      () => WatchRoomsUseCase(
        roomsRepository: _sl(),
      ),
    );

    _sl.registerLazySingleton(
      () => UpdateRoomsUseCase(
        roomsRepository: _sl(),
      ),
    );

    _sl.registerLazySingleton(
      () => GetItemsUseForRoomUseCase(
        itemsRepository: _sl(),
      ),
    );
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<RoomsWatcherBloc>(
        create: (context) => RoomsWatcherBloc(
          watchRoomsUseCase: _sl(),
        ),
      ),
      BlocProvider<RoomsUpdaterBloc>(
        create: (context) => RoomsUpdaterBloc(
          updateRoomsUseCase: _sl(),
        ),
      ),
      BlocProvider<RoomItemsBloc>(
        create: (context) => RoomItemsBloc(
          getItemsUseForRoomUseCase: _sl(),
        ),
      ),
    ];
  }
}
