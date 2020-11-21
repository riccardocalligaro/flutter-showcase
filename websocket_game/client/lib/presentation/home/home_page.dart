import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:undraw/illustrations.dart';
import 'package:undraw/undraw.dart';
import 'package:websocket_game/data/model/player_remote_model.dart';
import 'package:websocket_game/data/model/question_remote_model.dart';
import 'package:websocket_game/data/quiz_socket_manager.dart';

class HomePage extends StatefulWidget {
  final QuizSocketManager quizSocketManager;

  HomePage({
    Key key,
    @required this.quizSocketManager,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  /// Keep track of the user corrent / wrong answers
  int _currentScore = 0;

  /// The current displayed question
  QuestionRemoteModel _currentQuestion;

  List<String> _answers;

  /// The list of the players
  List<PlayerRemoteModel> _currentPlayers;

  Map<String, Color> _answerColors = Map();

  double _percentValue = 0.0;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    setupQuestionCallback();

    setupCurrentPlayersCallback();

    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(seconds: 5),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestion == null) {
      return Scaffold(
        body: UnDraw(
          color: Colors.blue,
          illustration: UnDrawIllustration.no_data,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 32.0),
          children: [
            _buildCurrentScore(),
            SizedBox(
              height: 16,
            ),
            _buildTopCountdown(),
            SizedBox(
              height: 32,
            ),
            _buildCurrentQuestion(),
            SizedBox(
              height: 32,
            ),
            ..._buildAnswersButtons(),
            SizedBox(
              height: 16,
            ),
            _buildLeaderboard()
          ],
        ),
      ),
    );
  }

  Widget _buildTopCountdown() {
    // return Text(_controller.value.toString());
    return Container(
      width: MediaQuery.of(context).size.width,
      child: NeumorphicProgress(
        percent: _percentValue,
        duration: Duration(seconds: 5),
        height: 25,
        style: ProgressStyle(
          variant: Colors.purple,
        ),
      ),
    );
  }

  Widget _buildCurrentScore() {
    return NeumorphicText(
      '$_currentScore',
      style: NeumorphicStyle(
        depth: 3, //customize depth here
        color: Colors.white, //customize color here
      ),
      textStyle: NeumorphicTextStyle(
        fontSize: 70, //customize size here
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCurrentQuestion() {
    return Text(
      Uri.decodeFull(_currentQuestion.question),
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<Widget> _buildAnswersButtons() {
    return List.generate(_answers.length, (index) {
      final answer = _answers[index];
      // return Text(_answerColors[answer].toString());
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: NeumorphicButton(
          style: NeumorphicStyle(
            color: _answerColors[answer],
          ),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 16,
              color: _answerColors[answer] != null ? Colors.white : null,
            ),
          ),
          onPressed: () {
            // check if has already answered with the answer colors
            if (_answerColors.values.isEmpty) {
              if (answer == _currentQuestion.correctAnswer) {
                setState(() {
                  _answerColors[answer] = Colors.green;
                  _currentScore += 1;
                });

                widget.quizSocketManager.answerQuestion(_currentScore);
              } else {
                setState(() {
                  _answerColors[answer] = Colors.red;
                });
              }
            }
          },
        ),
      );
    });
  }

  Widget _buildLeaderboard() {
    _currentPlayers.sort((a, b) => a.score.compareTo(b.score));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leaderboard',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        if (_currentPlayers.length == 0) Text('No current players'),
        ...List.generate(_currentPlayers.length, (index) {
          final player = _currentPlayers[index];
          Color color = Colors.orange;
          double size = MediaQuery.of(context).size.width - (index * 40);

          if (index > 3) {
            color = null;
          }

          return Container(
            height: 40,
            width: size,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                depth: 50,
                color: color,
                shadowLightColorEmboss: Colors.orange,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${player.nickname} - ${player.score}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        })
      ],
    );
  }

  void setupQuestionCallback() {
    widget.quizSocketManager.onQuestion((value) {
      setState(() {
        _currentQuestion = value;
        final allAnswers = _currentQuestion.incorrectAnswers;
        allAnswers.add(_currentQuestion.correctAnswer);
        allAnswers.shuffle();
        _answerColors.clear();
        setState(() {
          _answers = allAnswers;
        });
      });
    });
  }

  void setupCurrentPlayersCallback() {
    widget.quizSocketManager.onCurrentPlayers((value) {
      setState(() {
        _currentPlayers = value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
