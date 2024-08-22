import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/repository.dart';

class LogOutUsecase extends UseCase<void, NoParams> {
  final AuthenticationRepository _repository;

  LogOutUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _repository.logOut();
  }
}