import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gioco/core/failures.dart';
import 'package:gioco/core/usecase.dart';

void main() {
  group('correct usecase functioning', () {
    final useCase = TestUseCase();
    test('invalid params returns a failure', () {
      final invalidParams = TestParams(null);

      expect(useCase.execute(invalidParams),
          Left(Failure(errorMessage: 'null id')));
    });

    test('correct params return a value', () {
      final validParams = TestParams(1);

      expect(useCase.execute(validParams), Right(1));
    });
  });
}

class TestUseCase implements UseCase<int, TestParams> {
  @override
  Either<Failure, int> execute(TestParams params) {
    if (params.id == null) {
      return Left(Failure(errorMessage: 'null id'));
    }

    return Right(params.id);
  }
}

class TestParams {
  final int id;

  TestParams(this.id);
}
