import 'package:dartz/dartz.dart';
import 'package:memos/core/infrastructure/failures.dart';
import 'package:memos/core/infrastructure/resource.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';

abstract class MemosRepository {
  Stream<Resource<MemosPageData>> watchAllMemos(
    MemoState filter,
    TagDomainModel tag,
  );

  Future<Either<Failure, Success>> insertMemo(MemoDomainModel memo);

  Future<Either<Failure, Success>> deleteMemo(MemoDomainModel memo);
}
