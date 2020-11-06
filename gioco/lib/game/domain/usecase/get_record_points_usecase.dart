import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gioco/core/domain/failures.dart';
import 'package:gioco/core/domain/usecase.dart';
import 'package:gioco/game/domain/repository/questions_repository.dart';

class GetRecordPointsUseCase extends UseCase<int, NoParams> {
  QuestionsRepository questionsRepository;

  GetRecordPointsUseCase({@required this.questionsRepository});

  @override
  Either<Failure, int> execute(
    NoParams params,
  ) {
    return questionsRepository.getRecordPoints();
  }
}

class NoParams {}
