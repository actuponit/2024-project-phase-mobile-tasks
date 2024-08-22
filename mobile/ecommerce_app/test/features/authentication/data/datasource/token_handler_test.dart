import 'package:ecommerce_app/core/errors/exceptions.dart';
import 'package:ecommerce_app/features/authentication/data/datasources/token_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late TokenHandler tokenHandler;

  setUp((){
    mockSharedPreferences = MockSharedPreferences();
    tokenHandler = TokenHandlerImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getToken', (){
    test('returns token if there is one', () async {
      // arrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      // act
      final result = await tokenHandler.getToken();
      // assert
      expect(result, 'token');
    });
    test('returns empty string if there is no token', () async {
      // arrange
      when(mockSharedPreferences.getString('token')).thenReturn(null);
      // act
      final result = await tokenHandler.getToken();
      // assert
      expect(result, '');
    });
  });
  group('setToken', () {
    test('calles set method to store the token', () async{
      // arrange
      when(mockSharedPreferences.setString('token', 'token')).thenAnswer((_) async => true);
      // act
      await tokenHandler.saveToken('token');
      // assert
      verify(mockSharedPreferences.setString('token', 'token'));
    });
  });
  group('removeToken', () {
    test('calles remove method to delete the token when the token is available', () async{
      // arrange
      when(mockSharedPreferences.remove('token')).thenAnswer((_) async => true);
      when(mockSharedPreferences.containsKey('token')).thenReturn(true);
      // act
      await tokenHandler.removeToken();
      // assert
      verify(mockSharedPreferences.remove('token'));
    });
    test('throws cache excption when a token is not available', () async{
      // arrange
      when(mockSharedPreferences.remove('token')).thenAnswer((_) async => true);
      when(mockSharedPreferences.containsKey('token')).thenReturn(false);
      // act
      final call = tokenHandler.removeToken;
      // assert
      expect(call(), throwsA(isA<CacheException>()));
      verifyNever(mockSharedPreferences.remove('token'));
    });
  });
}