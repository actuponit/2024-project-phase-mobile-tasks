import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/entities.dart';
import '../repositories/repository.dart';

class SignUpUsecase extends UseCase<User, SignUpParams> {
  final AuthenticationRepository _repository;

  SignUpUsecase(this._repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await _repository.signUp(
        email: params.email, password: params.password, name: params.name);
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String name;

  const SignUpParams(
      {required this.email, required this.password, required this.name});

  @override
  List<Object> get props => [email, password, name];
}