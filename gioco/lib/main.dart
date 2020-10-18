import 'package:flutter/material.dart';
import 'package:gioco/game/data/questions_repository_impl.dart';
import 'package:gioco/game/domain/usecase/get_question_usecase.dart';
import 'package:gioco/game/presentation/colors_page.dart';

void main() {
  runApp(ColorsGame());
}

/// Simple game to test your reflexes and select the right
/// color
class ColorsGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colors game',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xff121212),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ColorsPage(
        getQuestionUseCase: GetQuestionUseCase(
          questionsRepository: QuestionsRepositoryImpl(),
        ),
      ),
    );
  }
}
