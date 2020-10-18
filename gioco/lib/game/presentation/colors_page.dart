import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gioco/core/failures.dart';
import 'package:gioco/game/domain/model/question_domain_model.dart';
import 'package:gioco/game/domain/usecase/get_question_usecase.dart';
import 'package:gioco/game/presentation/widget/painters/answer_circle_section_painter.dart';
import 'package:gioco/game/presentation/widget/section.dart';

class ColorsPage extends StatefulWidget {
  final GetQuestionUseCase getQuestionUseCase;

  const ColorsPage({
    Key key,
    @required this.getQuestionUseCase,
  }) : super(key: key);

  @override
  _ColorsPageState createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  /// The number of colors that the user has tapped correctly
  int score = 0;

  /// If the user has tapped the correct number it shows the
  /// reaction time in milliseoncs
  // int reactionTime = 0;

  /// The generated question
  QuestionDomainModel question;

  /// If there is an error this will be not null
  Failure failure;

  /// Timer that is used for checking if the user answers
  /// in the given time
  Timer countdownTimer;

  /// Reamaining seconds that the user has to answer the question
  int remainingSeconds;

  @override
  void initState() {
    super.initState();

    // get the new question from the repository
    getNewQuestion(cancelCountdown: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: 40,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text(
                      '$score',
                      style: TextStyle(
                        fontSize: 48,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    if (remainingSeconds > 0)
                      Text(
                        '$remainingSeconds seconds remaining',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            ...buildQuestionItems(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildQuestionItems() {
    double sectionAngle = 360 / question.possibleAnswers.length;
    return [
      Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: question.generatedColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
      // Text(question.possibleAnswers.length.toString()),
      ...question.possibleAnswers
          .asMap()
          .map(
            (i, element) =>
                MapEntry(i, buildAnswerCircle(i, element, sectionAngle)),
          )
          .values
          .toList(),
    ];
  }

  Widget buildAnswerCircle(int index, Section section, double sectionAngle) {
    return GestureDetector(
      onTap: () {
        if (section.color == question.generatedColor) {
          setState(() {
            score += 1;
          });

          getNewQuestion();
        } else {
          setState(() {
            score = 0;
          });

          getNewQuestion();
        }
      },
      child: CustomPaint(
        painter: AnswerCircleSectionCustomPainter(
          length: question.possibleAnswers.length,
          index: index,
          section: Section(color: section.color, radius: section.radius),
          sectionAngle: sectionAngle,
        ),
        child: Container(),
      ),
    );
  }

  Future<void> reactToCorrectAnswer(Color correctColor) async {
    setState(() {
      score += 1;
    });

    await Future.delayed(Duration(milliseconds: 1000));

    getNewQuestion();
  }

  Future<void> reactToWrongAnswer(Color wronwColor, Color correctColor) async {
    setState(() {
      score = 0;
    });

    await Future.delayed(Duration(milliseconds: 1000));

    getNewQuestion();
  }

  void getNewQuestion({
    bool cancelCountdown = true,
  }) {
    final questionResponse =
        widget.getQuestionUseCase.execute(GetQuestionUseCaseParams(
      score,
    ));

    questionResponse.fold((l) {
      setState(() => failure = l);
    }, (r) {
      setState(() {
        question = r;
        remainingSeconds = question.timeToAnswer ~/ 1000;
      });

      if (cancelCountdown) {
        countdownTimer.cancel();
      }
      startAnswerCountdownTimer();
    });
  }

  void startAnswerCountdownTimer() {
    countdownTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (remainingSeconds < 1) {
          timer.cancel();

          setState(() {
            score = 0;
          });

          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: Text('Countdown expired!'),
          //       content: Text('Retry next time.'),
          //     );
          //   },
          // );
        } else {
          setState(() => remainingSeconds = remainingSeconds - 1);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer.cancel();
  }
}
