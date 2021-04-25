import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:museo_zuccante/core/data/local/mz_database.dart';
import 'package:museo_zuccante/core/data/remote/mz_dio_client.dart';
import 'package:museo_zuccante/feature/items/items_container.dart';
import 'package:museo_zuccante/feature/rooms/rooms_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'infrastructure/network_info.dart';

final sl = GetIt.instance;

class CoreContainer {
  static Future<void> init() async {
    // wait for all modules

    sl.registerLazySingleton<MZDatabase>(() => MZDatabase());

    sl.registerLazySingleton<Connectivity>(
      () => Connectivity(),
    );

    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: sl()),
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    sl.registerLazySingleton<Dio>(
      MZDioClient.createDio,
    );

    await ItemsContainer.init();
    await RoomsContainer.init();
  }

  static List<BlocProvider> getBlocProviders() {
    // get all modules providers
    return [
      ...ItemsContainer.getBlocProviders(),
      ...RoomsContainer.getBlocProviders(),
    ];
  }
}
