import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:gioco/core/extension/colors_ext.dart';
import 'package:gioco/core/failures.dart';
import 'package:gioco/game/domain/model/question_domain_model.dart';
import 'package:gioco/game/domain/repository/questions_repository.dart';
import 'package:gioco/game/presentation/widget/section.dart';

class QuestionsRepositoryImpl extends QuestionsRepository {
  /// 4 possible correct answers, 3 seconds to answer, 1 point
  static const int DIFFICULTY_EASY = 1;

  /// 6 possible correct answers, 3 seconds to answer, 2 points
  static const int DIFFICULTY_MEDIUM = 5;

  /// 6 possible correct answers, 2 seconds to answer, 5 points
  static const int DIFFICULTY_HARD = 9;

  /// 8 possible correct answers, 2 seconds to answer, 10 points
  static const int DIFFICULTY_EXTREME = 11;

  /// Number of questions that the user has answered correctly
  int correctAnswers = 0;

  /// The score starts at 0, it is saved every time if it is an high score
  int score = 0;

  @override
  Either<Failure, QuestionDomainModel> getRandomQuestion() {
    try {
      Random random = Random();

      int answersToGenerate = 4;

      // time in milliseconds to answer the question, changes with the
      // difficulty of the question
      int timeToAnswer = 3000;

      // easy = 1, medium = 2, hard = 5, extreme = 10
      int points = 1;

      // if (_correctAnswers <= DIFFICULTY_MEDIUM) {
      //   answersToGenerate = 10;
      // } else if (_correctAnswers <= 11) {}

      // get a random list of generated colors
      final generatedColors = GColors.getRandomList(answersToGenerate);

      // the correct answer is a random of the random generated colors
      final correctAnswer =
          generatedColors[random.nextInt(generatedColors.length)];

      // map the possible answers to the correct type, remember to always
      // call .toList() otherwise it will return an iterable
      final possibleAnswers = generatedColors
          .map(
            (e) => Section(color: e, radius: 50),
          )
          .toList();

      return Right(
        QuestionDomainModel(
          generatedColor: correctAnswer,
          possibleAnswers: possibleAnswers,
          timeToAnswer: timeToAnswer,
          points: points,
        ),
      );
    } catch (e) {
      return Left(Failure());
    }
  }
}
