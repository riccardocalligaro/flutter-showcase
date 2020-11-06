import 'package:dartz/dartz.dart';
import 'package:gioco/core/domain/failures.dart';

abstract class UseCase<Type, Params> {
  Either<Failure, Type> execute(Params params);
}
