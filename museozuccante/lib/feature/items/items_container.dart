import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_local_datasource.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_remote_datasource.dart';
import 'package:museo_zuccante/feature/items/data/repository/items_repository_impl.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';
import 'package:museo_zuccante/feature/items/domain/usecases/update_items_usecase.dart';
import 'package:museo_zuccante/feature/items/domain/usecases/watch_items_usecase.dart';
import 'package:museo_zuccante/feature/items/item/item_container.dart';
import 'package:museo_zuccante/feature/items/presentation/search/search_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/watcher/items_watcher_bloc.dart';

final _sl = GetIt.instance;

class ItemsContainer {
  static Future<void> init() async {
    _sl.registerLazySingleton(() => ItemsLocalDatasource(_sl()));

    _sl.registerLazySingleton(() => ItemsRemoteDatasource(dio: _sl()));

    _sl.registerLazySingleton<ItemsRepository>(
      () => ItemsRepositoryImpl(
        networkInfo: _sl(),
        itemsRemoteDatasource: _sl(),
        itemsLocalDatasource: _sl(),
        sharedPreferences: _sl(),
      ),
    );

    _sl.registerLazySingleton(
      () => WatchItemsUseCase(
        itemsRepository: _sl(),
      ),
    );

    _sl.registerLazySingleton(
      () => UpdateItemsUseCase(
        itemsRepository: _sl(),
      ),
    );

    await ItemContainer.init();
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<ItemsWatcherBloc>(
        create: (context) => ItemsWatcherBloc(
          watchItemsUseCase: _sl(),
        ),
      ),
      BlocProvider<ItemsUpdaterBloc>(
        create: (context) => ItemsUpdaterBloc(
          updateItemsUseCase: _sl(),
        ),
      ),
      BlocProvider<SearchBloc>(
        create: (context) => SearchBloc(
          itemsRepository: _sl(),
        ),
      ),
      ...ItemContainer.getBlocProviders(),
    ];
  }
}
