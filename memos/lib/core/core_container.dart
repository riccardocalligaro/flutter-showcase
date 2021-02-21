import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:memos/feature/memos/memos_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/data/memos_database.dart';

final sl = GetIt.instance;

class CoreContainer {
  static Future<void> init() async {
    // wait for all modules
    await MemosContainer.init();

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    final database =
        await $FloorMemosDatabase.databaseBuilder('museum_zuccante.db').build();
    sl.registerLazySingleton(() => database);

    sl.registerLazySingleton(() => database.memosLocalDatasource);
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      ...MemosContainer.getBlocProviders(),
    ];
  }
}
