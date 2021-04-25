import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:museo_zuccante/core/data/generics/resource.dart';
import 'package:museo_zuccante/core/infrastructure/error/types/failures.dart';

mixin UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}

mixin StreamUseCase<Type, Params> {
  Stream<Resource<Type>> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
