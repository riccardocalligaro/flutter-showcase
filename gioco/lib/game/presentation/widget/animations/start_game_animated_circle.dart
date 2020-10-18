import 'package:flutter/material.dart';
import 'package:gioco/game/domain/model/question_domain_model.dart';
import 'package:gioco/game/domain/usecase/get_question_usecase.dart';
import 'package:gioco/game/presentation/widget/painters/answer_circle_section_painter.dart';

import '../section.dart';

class StartGameAnimatedCircle extends StatefulWidget {
  final GetQuestionUseCase getQuestionUseCase;
  final VoidCallback startGame;

  StartGameAnimatedCircle({
    Key key,
    @required this.getQuestionUseCase,
    @required this.startGame,
  }) : super(key: key);

  @override
  _StartGameAnimatedCircleState createState() =>
      _StartGameAnimatedCircleState();
}

class _StartGameAnimatedCircleState extends State<StartGameAnimatedCircle>
    with SingleTickerProviderStateMixin {
  AnimationController _rotationController;

  QuestionDomainModel question;

  double sectionAngle;

  @override
  void initState() {
    super.initState();

    question = widget.getQuestionUseCase.questionsRepository
        .getRandomQuestion(currentScore: 0)
        .getOrElse(() => null);

    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    // _rotationController.repeat();

    sectionAngle = 360 / question.possibleAnswers.length;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            widget.startGame();
          },
          child: Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                size: 62,
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _rotationController,
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
              angle: _rotationController.value * 6.3,
              child: Stack(
                children: [
                  ...question.possibleAnswers
                      .asMap()
                      .map(
                        (i, element) => MapEntry(
                            i, buildAnswerCircle(i, element, sectionAngle)),
                      )
                      .values
                      .toList(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildAnswerCircle(int index, Section section, double sectionAngle) {
    return SizedBox(
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

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
}
