import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/entities.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, void>> logIn(
      {required String email, required String password});
  Future<Either<Failure, User>> signUp(
      {required String email, required String password, required String name});
  Future<Either<Failure, void>> logOut();
  Future<Either<Failure, User>> getUser();
}