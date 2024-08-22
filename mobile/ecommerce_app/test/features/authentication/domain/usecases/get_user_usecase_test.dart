import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/authentication/domain/entities/entities.dart';
import 'package:ecommerce_app/features/authentication/domain/usecases/get_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockAuthenticationRepository authRepository;
  late GetUserUsecase getUserUsecase;

  setUp(() {
    authRepository = MockAuthenticationRepository();
    getUserUsecase = GetUserUsecase(authRepository);
  });

  const user = User(id: '1', email: 'im@gmail', name: 'name');

  test('should call getUser method from repository and return user when success', () async {
    // arrange
    when(authRepository.getUser()).thenAnswer((_) async => const Right(user));
    // act
    final result = await getUserUsecase(NoParams());
    // assert
    verify(authRepository.getUser());
    expect(result, const Right(user));
  });
}