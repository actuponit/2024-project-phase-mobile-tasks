import 'dart:convert';

import 'package:ecommerce_app/core/errors/exceptions.dart';
import 'package:ecommerce_app/core/urls/auth.dart';
import 'package:ecommerce_app/features/authentication/data/datasources/remote_datasource.dart';
import 'package:ecommerce_app/features/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockCustomHttp mockClient;
  late RemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockClient = MockCustomHttp();
    remoteDataSource = RemoteDataSourceImpl(client: mockClient);
  });

  const user = UserModel(id: '1', email: 'im@gmail', name: 'name');

  group('getUser', (){
    test('should return user when the call to remote data source is successful', () async {
      // arrange
      String responseString = fixtureReader('auth/me.json');
      when(mockClient.get(any)).thenAnswer((_) async => Response(responseString, 200));  
      // act
      final result = await remoteDataSource.getUser();
      // assert
      verify(mockClient.get(Uri.parse(me)));
      expect(result, user);

    });

    test('should throw a ServerException when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockClient.get(any)).thenAnswer((_) async => Response('Not found', 400));
      // act
      final call = remoteDataSource.getUser;
      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('login', (){
    test('should return a token when the call to remote data source is successful', () async {
      // arrange
      String response = fixtureReader('auth/login.json');
      when(mockClient.post(any, body: anyNamed('body'))).thenAnswer((_) async => Response(response, 201));
      // act
      final result = await remoteDataSource.login('im@gmail', 'password');
      // assert
      verify(mockClient.post(Uri.parse(loginUrl), body: json.encode({'email': 'im@gmail', 'password': 'password'})));
      expect(result, 'token');
    });

    test('should throw a ServerException when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockClient.post(any, body: anyNamed('body'))).thenAnswer((_) async => Response('Not found', 400));
      // act
      final call = remoteDataSource.login;
      // assert
      expect(() => call('', ''), throwsA(isA<ServerException>()));
    });
  });
  
  group('register', (){
    test('should return a user when the call to remote data source is successful', () async {
      // arrange
      String response = fixtureReader('auth/register.json');
      when(mockClient.post(any, body: anyNamed('body'))).thenAnswer((_) async => Response(response, 201));
      // act
      final result = await remoteDataSource.register(user.email, 'password', user.name);
      // assert
      verify(mockClient.post(Uri.parse(signupUrl), body: json.encode({'email': user.email, 'password': 'password', 'name': user.name})));
      expect(result, user);
    });

    test('should throw a ServerException when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockClient.post(any, body: anyNamed('body'))).thenAnswer((_) async => Response('Not found', 400));
      // act
      final call = remoteDataSource.register;
      // assert
      expect(() => call('', '', ''), throwsA(isA<ServerException>()));
    });
  });
}