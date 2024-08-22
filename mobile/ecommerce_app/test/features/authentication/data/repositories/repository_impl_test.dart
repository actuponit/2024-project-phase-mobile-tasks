import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/exceptions.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/authentication/data/models/user_model.dart';
import 'package:ecommerce_app/features/authentication/data/repositories/repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main(){
  late MockTokenHandler tokenHandler;
  late MockRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImpl repository;

  const SERVER_FAILURE = 'Server Failure';

  setUp((){
    tokenHandler = MockTokenHandler();
    remoteDataSource = MockRemoteDataSource();

    repository = AuthenticationRepositoryImpl(tokenHandler: tokenHandler, dataSource: remoteDataSource);
  });

  const user = UserModel(id: '1', email: 'im@gmail', name: 'name');
  const token = 'token';
  const password = 'password';

  group('getUser', (){
    test('should return user when the call to remote data source is successful', () async {
      // arrange
      when(remoteDataSource.getUser()).thenAnswer((_) async => user);
      // act
      final result = await repository.getUser();
      // assert
      expect(result, const Right(user));
    });

    test('should return a ServerFailure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(remoteDataSource.getUser()).thenThrow(ServerException());
      // act
      final result = await repository.getUser();
      // assert
      expect(result, const Left(ServerFailure(SERVER_FAILURE)));
    });
  });

  group('login', (){
    test('should save the token when the call to remote data source is successful', () async {
      // arrange
      when(remoteDataSource.login(user.email, password)).thenAnswer((_) async => token);
      when(tokenHandler.saveToken(token)).thenAnswer((_) async {});
      // act
      final result = await repository.logIn(email: user.email, password: password);

      // assert
      expect(result, const Right(null));
      verify(tokenHandler.saveToken(token));
    });

    test('should return a ServerFailure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(remoteDataSource.login(user.email, password)).thenThrow(ServerException());
      // act
      final result = await repository.logIn(email: user.email, password: password);
      // assert
      expect(result, const Left(ServerFailure(SERVER_FAILURE)));
    });
  });
  
  group('logout', () {
    test('should remove the token when token exists', () async {
      // arrange
      when(tokenHandler.removeToken()).thenAnswer((_) async {});
      // act
      final result = await repository.logOut();

      // assert
      expect(result, const Right(null));
      verify(tokenHandler.removeToken());
    });
    test('should return CachFailure when token doesn\'t exists', () async {
      // arrange
      when(tokenHandler.removeToken()).thenThrow(CacheException());
      // act
      final result = await repository.logOut();

      // assert
      expect(result, const Left(CacheFailure('Cache Failure')));
      verify(tokenHandler.removeToken());
    });
  });

  group('register', () {
    test('should return user when remote call is success', () async {
      // arrange
      when(remoteDataSource.register(user.email, password, user.name)).thenAnswer((_) async=> user);
      // act
      final result = await repository.signUp(email: user.email, password: password, name: user.name);
      // assert
      expect(result, const Right(user));
      verify(remoteDataSource.register(user.email, password, user.name));
    });
    test('should return ServerFailure when remote call is not successfull', () async {
      // arrange
      when(remoteDataSource.register(user.email, password, user.name)).thenThrow(ServerException());
      // act
      final result = await repository.signUp(email: user.email, password: password, name: user.name);

      // assert
      expect(result, const Left(ServerFailure('Server Failure')));
    });
  });

}