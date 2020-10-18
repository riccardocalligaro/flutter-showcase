import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gioco/core/failures.dart';
import 'package:gioco/game/domain/model/question_domain_model.dart';
import 'package:gioco/game/domain/usecase/get_question_usecase.dart';
import 'package:gioco/game/presentation/widget/painters/answer_circle_section_painter.dart';
import 'package:gioco/game/presentation/widget/section.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionPage extends StatefulWidget {
  final GetQuestionUseCase getQuestionUseCase;
  final VoidCallback stopGame;

  const QuestionPage({
    Key key,
    @required this.getQuestionUseCase,
    @required this.stopGame,
  }) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  /// The number of colors that the user has tapped correctly
  int score = 0;

  Color scaffoldColor = Color(0xff121212);

  /// The generated question
  QuestionDomainModel question;

  /// If there is an error this will be not null
  Failure failure;

  /// Timer that is used for checking if the user answers
  /// in the given time
  Timer countdownTimer;

  /// Reamaining seconds that the user has to answer the question
  int remainingSeconds;

  File correctAudioFile;

  File wrongAudioFile;

  @override
  void initState() {
    super.initState();
    // get the new question from the repository
    getNewQuestion(cancelCountdown: false);

    setupAudio();
  }

  void setupAudio() async {
    AudioCache player = AudioCache();

    final correctAudio = await player.load(
      'sfx/correct.mp3',
    );

    final wrongAudio = await player.load(
      'sfx/wrong.mp3',
    );

    setState(() {
      correctAudioFile = correctAudio;
      wrongAudioFile = wrongAudio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
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
                      style: GoogleFonts.pressStart2p(
                        fontSize: 48,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    if (remainingSeconds > 0)
                      Text(
                        '$remainingSeconds seconds remaining'.toUpperCase(),
                        style: GoogleFonts.pressStart2p(
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 82.0),
              child: Stack(
                children: buildQuestionItems(),
              ),
            )
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
          reactToCorrectAnswer();
        } else {
          reactToWrongAnswer();
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

  Future<void> reactToCorrectAnswer() async {
    setState(() {
      score += 1;
    });

    // play the audio
    final player = AudioPlayer();
    player.play(correctAudioFile.path, isLocal: true);

    getNewQuestion();
  }

  Future<void> reactToWrongAnswer() async {
    setState(() {
      score = 0;
      scaffoldColor = Colors.red[800];
    });

    final player = AudioPlayer();
    player.play(wrongAudioFile.path, isLocal: true);

    await Future.delayed(Duration(milliseconds: 300));
    widget.stopGame();
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
      (timer) async {
        if (remainingSeconds <= 1) {
          timer.cancel();

          setState(() {
            score = 0;
          });

          AudioCache player = AudioCache();

          await player.play(
            'sfx/time.mp3',
          );

          widget.stopGame();
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
