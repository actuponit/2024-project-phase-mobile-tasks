import 'dart:convert';

import 'package:ecommerce_app/features/authentication/data/models/user_model.dart';
import 'package:ecommerce_app/features/authentication/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {

  const user = UserModel(id: '1', email: 'im@gmail', name: 'name');

  test('should be a subclass of User entity', () {
    // assert
    expect(user, isA<User>());
  });

  test('should return UserModel from the appropriate json format', (){
    // arrange
    var userJson = json.decode(fixtureReader('user.json'));
    // act
    final result = UserModel.fromJson(userJson);
    // assert
    expect(result, user);
  });

  test('should return UserModel from the appropriate User entity', (){
    // arrange
    const userEntity = User(id: '1', email: 'im@gmail', name: 'name');
    // act
    final result = UserModel.fromEntity(userEntity);
    // assert
    expect(result, user);
  });
}