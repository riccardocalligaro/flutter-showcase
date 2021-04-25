import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/domain/domain/usecase.dart';
import 'package:museo_zuccante/core/infrastructure/error/types/failures.dart';

import 'package:museo_zuccante/core/infrastructure/error/types/successes.dart';
import 'package:museo_zuccante/feature/rooms/domain/repository/rooms_repository.dart';

class UpdateRoomsUseCase implements UseCase<Success, UpdateRoomsParams> {
  final RoomsRepository roomsRepository;

  UpdateRoomsUseCase({
    @required this.roomsRepository,
  });

  @override
  Future<Either<Failure, Success>> execute(UpdateRoomsParams params) {
    return roomsRepository.updateRooms(ifNeeded: params.ifNeeded);
  }
}

class UpdateRoomsParams {
  final bool ifNeeded;

  UpdateRoomsParams({@required this.ifNeeded});
}
