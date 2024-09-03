import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/authentication/domain/entities/entities.dart';
import 'package:ecommerce_app/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockAuthenticationRepository authRepository;
  late SignUpUsecase signUpUseCase;

  setUp(() {
    authRepository = MockAuthenticationRepository();
    signUpUseCase = SignUpUsecase(authRepository);
  });

  const user = User(id: '1', email: 'im@gmail', name: 'name');
  test('should call signUp method from repository and return user when success', () async {
    // arrange
    when(authRepository.signUp(email: 'im@gmail', password: 'passowrd', name: 'name'))
        .thenAnswer((_) async => const Right(user));
    // act
    final result = await signUpUseCase(const SignUpParams(email: 'im@gmail', password: 'passowrd', name: 'name'));
    // assert
    verify(authRepository.signUp(email: 'im@gmail', password: 'passowrd', name: 'name'));
    expect(result, const Right(user));
  });
}