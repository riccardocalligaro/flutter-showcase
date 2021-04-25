import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:museo_zuccante/feature/items/item/presentation/bloc/item_bloc.dart';

import 'domain/usecases/get_item_usecase.dart';

final sl = GetIt.instance;

class ItemContainer {
  static Future<void> init() async {
    sl.registerLazySingleton(
      () => GetItemUseCase(
        itemsRepository: sl(),
      ),
    );
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<ItemBloc>(
        create: (context) => ItemBloc(
          getItemUseCase: sl(),
        ),
      ),
    ];
  }
}
