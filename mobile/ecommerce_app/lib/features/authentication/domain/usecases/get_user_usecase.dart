import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/entities.dart';
import '../repositories/repository.dart';

class GetUserUsecase extends UseCase<User, NoParams> {
  final AuthenticationRepository repository;

  GetUserUsecase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUser();
  }
}