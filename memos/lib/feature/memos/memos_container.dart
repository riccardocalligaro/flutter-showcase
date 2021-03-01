import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:memos/feature/memos/presentation/bloc/memos/memos_watcher_bloc.dart';
import 'package:memos/feature/memos/presentation/bloc/share/share_bloc.dart';

import 'data/repository/memos_repository_impl.dart';
import 'domain/repository/memos_repository.dart';

final _sl = GetIt.instance;

class MemosContainer {
  static Future<void> init() async {
    _sl.registerLazySingleton<MemosRepository>(
      () => MemosRepositoryImpl(
        memosLocalDatasource: _sl(),
      ),
    );
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<MemosWatcherBloc>(
        create: (BuildContext context) => MemosWatcherBloc(
          memosRepository: _sl(),
        ),
      ),
      BlocProvider<ShareBloc>(
        create: (BuildContext context) => ShareBloc(
          memosRepository: _sl(),
        ),
      ),
    ];
  }
}
