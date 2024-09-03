import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/repository.dart';

class LogInUsecase extends UseCase<void, LogInParams> {
  final AuthenticationRepository _repository;

  LogInUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(LogInParams params) async {
    return await _repository.logIn(email: params.email, password: params.password);
  }
}

class LogInParams extends Equatable {
  final String email;
  final String password;

  LogInParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}