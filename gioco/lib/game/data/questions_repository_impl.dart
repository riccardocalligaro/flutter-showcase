import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gioco/core/extension/colors_ext.dart';
import 'package:gioco/core/failures.dart';
import 'package:gioco/game/data/questions_constants.dart';
import 'package:gioco/game/domain/model/question_domain_model.dart';
import 'package:gioco/game/domain/repository/questions_repository.dart';
import 'package:gioco/game/presentation/widget/section.dart';

class QuestionsRepositoryImpl extends QuestionsRepository {
  /// Number of questions that the user has answered correctly
  int correctAnswers = 0;

  /// The score starts at 0, it is saved every time if it is an high score
  int score = 0;

  @override
  Either<Failure, QuestionDomainModel> getRandomQuestion({
    @required int currentScore,
  }) {
    try {
      Random random = Random();

      final questionParams = getQuestionDifficultyParams(currentScore);

      // easy = 1, medium = 2, hard = 5, extreme = 10
      int points = questionParams.value1;

      // time in milliseconds to answer the question, changes with the
      // difficulty of the question
      int timeToAnswer = questionParams.value2;

      /// numbers of possible questions
      int answersToGenerate = questionParams.value3;

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

  /// Points, timeToAnswer, answers to generate
  Tuple3<int, int, int> getQuestionDifficultyParams(int currentScore) {
    // easy = 1, medium = 2, hard = 5, extreme = 10
    int points = QuestionsConstants.EASY_POINTS;

    // time in milliseconds to answer the question, changes with the
    // difficulty of the question
    int timeToAnswer = QuestionsConstants.EASY_TIME_TO_ANSWER;

    int answersToGenerate = QuestionsConstants.EASY_ANSWERS;

    if (currentScore >= QuestionsConstants.DIFFICULTY_MEDIUM &&
        currentScore < QuestionsConstants.DIFFICULTY_HARD) {
      answersToGenerate = QuestionsConstants.MEDIUM_ANSWERS;
      points = QuestionsConstants.MEDIUM_POINTS;
    } else if (currentScore >= QuestionsConstants.DIFFICULTY_HARD &&
        currentScore < QuestionsConstants.DIFFICULTY_EXTREME) {
      answersToGenerate = QuestionsConstants.HARD_ANSWERS;
      points = QuestionsConstants.HARD_POINTS;
      timeToAnswer = QuestionsConstants.HARD_TIME_TO_ANSWER;
    } else if (currentScore >= QuestionsConstants.DIFFICULTY_EXTREME &&
        currentScore < QuestionsConstants.DIFFICULTY_ONLY_AI) {
      answersToGenerate = QuestionsConstants.EXTREME_ANSWERS;
      points = QuestionsConstants.EXTREME_POINTS;
      timeToAnswer = QuestionsConstants.EXTREME_TIME_TO_ANSWER;
    } else if (currentScore >= QuestionsConstants.DIFFICULTY_ONLY_AI) {
      answersToGenerate = QuestionsConstants.AI_ANSWERS;
      points = QuestionsConstants.AI_POINTS;
      timeToAnswer = QuestionsConstants.AI_TIME_TO_ANSWER;
    }

    return Tuple3(points, timeToAnswer, answersToGenerate);
  }
}
