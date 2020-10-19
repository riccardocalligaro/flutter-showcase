import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:gioco/game/data/questions_constants.dart';
import 'package:gioco/game/data/questions_repository_impl.dart';
import 'package:gioco/game/domain/usecase/get_question_usecase.dart';
import 'package:gioco/game/domain/usecase/get_record_points_usecase.dart';
import 'package:gioco/game/presentation/start_game_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Starts game and saves high score', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    GetIt getIt = GetIt.instance;

    SharedPreferences.setMockInitialValues({});
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final repository = QuestionsRepositoryImpl(
      sharedPreferences: sharedPreferences,
    );

    getIt.registerLazySingleton(() => repository);
    getIt.registerLazySingleton(
        () => GetRecordPointsUseCase(questionsRepository: repository));

    getIt.registerLazySingleton(
        () => GetQuestionUseCase(questionsRepository: repository));

    await tester.pumpWidget(
      MaterialApp(
        home: StartGamePage(
          getRecordPointsUseCase: getIt.get<GetRecordPointsUseCase>(),
          startGame: () {},
        ),
      ),
    );

    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    expect(find.text('HIGH SCORE: 0'), findsOneWidget);

    sharedPreferences.setInt(QuestionsConstants.MAX_SCORE_KEY, 11);

    await tester.pumpWidget(
      MaterialApp(
        home: StartGamePage(
          getRecordPointsUseCase: getIt.get<GetRecordPointsUseCase>(),
          startGame: () {},
        ),
      ),
    );

    expect(find.text('HIGH SCORE: 11'), findsOneWidget);
  });
}
