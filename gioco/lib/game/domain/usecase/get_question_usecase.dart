import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gioco/core/failures.dart';
import 'package:gioco/core/usecase.dart';
import 'package:gioco/game/domain/model/question_domain_model.dart';
import 'package:gioco/game/domain/repository/questions_repository.dart';

class GetQuestionUseCase
    extends UseCase<QuestionDomainModel, GetQuestionUseCaseParams> {
  QuestionsRepository questionsRepository;

  GetQuestionUseCase({@required this.questionsRepository});

  @override
  Either<Failure, QuestionDomainModel> execute(
    GetQuestionUseCaseParams params,
  ) {
    return questionsRepository.getRandomQuestion(
      currentScore: params.currentScore,
    );
  }
}

class GetQuestionUseCaseParams {
  /// Based on this we choose the difficulty of the next
  /// question to show
  final int currentScore;

  GetQuestionUseCaseParams(this.currentScore);

  @override
  String toString() => 'GetQuestionUseCaseParams(currentScore: $currentScore)';
}
