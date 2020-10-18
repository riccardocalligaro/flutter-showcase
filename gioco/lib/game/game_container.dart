import 'package:get_it/get_it.dart';
import 'package:gioco/game/data/questions_repository_impl.dart';
import 'package:gioco/game/domain/repository/questions_repository.dart';
import 'package:gioco/game/domain/usecase/get_question_usecase.dart';
import 'package:gioco/game/domain/usecase/get_record_points_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class GameContainer {
  static Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    sl.registerLazySingleton<QuestionsRepository>(
      () => QuestionsRepositoryImpl(
        sharedPreferences: sl(),
      ),
    );

    sl.registerLazySingleton(
      () => GetQuestionUseCase(
        questionsRepository: sl(),
      ),
    );

    sl.registerLazySingleton(
      () => GetRecordPointsUseCase(
        questionsRepository: sl(),
      ),
    );
  }
}
