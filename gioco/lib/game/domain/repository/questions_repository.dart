import 'package:dartz/dartz.dart';
import 'package:gioco/core/failures.dart';
import 'package:gioco/game/domain/model/question_domain_model.dart';

abstract class QuestionsRepository {
  Either<Failure, QuestionDomainModel> getRandomQuestion();
}
