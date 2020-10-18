import 'package:flutter/material.dart';
import 'package:gioco/game/game_container.dart';
import 'package:gioco/game/presentation/question_page.dart';
import 'package:gioco/game/presentation/start_game_page.dart';

/// 'Navigator' page which handles the page
/// to show, whether the start one or the question one
class GamePage extends StatefulWidget {
  GamePage({Key key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool showStart = true;

  @override
  Widget build(BuildContext context) {
    if (showStart) {
      return StartGamePage(getRecordPointsUseCase: sl(), startGame: startGame);
    } else {
      return QuestionPage(getQuestionUseCase: sl(), stopGame: stopGame);
    }
  }

  void startGame() {
    setState(() {
      showStart = false;
    });
  }

  void stopGame() {
    setState(() {
      showStart = true;
    });
  }
}
