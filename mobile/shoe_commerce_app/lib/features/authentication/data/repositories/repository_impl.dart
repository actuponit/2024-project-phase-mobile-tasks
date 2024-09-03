import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/remote_datasource.dart';
import '../datasources/token_handler.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {

  final TokenHandler tokenHandler;
  final RemoteDataSource dataSource;

  AuthenticationRepositoryImpl({required this.tokenHandler, required this.dataSource});

  final SERVER_FAILURE = 'Server Failure';
  final UNEXPECTED_FAILURE = 'Unkown Failure';
  final CACHE_FAILURE = 'Cache Failure';
  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final user = await dataSource.getUser();
      return Right(user);
    } on ServerException {
      return Left(ServerFailure(SERVER_FAILURE));
    } catch (e) {
      return Left(UnexpectedFailure(UNEXPECTED_FAILURE));
    }
  }

  @override
  Future<Either<Failure, void>> logIn({required String email, required String password}) async {
    try {
      final token = await dataSource.login(email, password);
      await tokenHandler.saveToken(token);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure(SERVER_FAILURE));
    } catch (e) {
      return Left(UnexpectedFailure(UNEXPECTED_FAILURE));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await tokenHandler.removeToken();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure(CACHE_FAILURE));
    } catch (e) {
      return Left(UnexpectedFailure(UNEXPECTED_FAILURE));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({required String email, required String password, required String name}) async {
    try {
      final user = await dataSource.register(email, password, name);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure(SERVER_FAILURE));
    } catch (e) {
      return Left(UnexpectedFailure(UNEXPECTED_FAILURE));
    }
  }
  
}