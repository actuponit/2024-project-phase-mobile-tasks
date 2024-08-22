import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/authentication/domain/entities/entities.dart';
import 'package:ecommerce_app/features/authentication/domain/usecases/log_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockAuthenticationRepository authRepository;
  late LogInUsecase logInUseCase;

  setUp(() {
    authRepository = MockAuthenticationRepository();
    logInUseCase = LogInUsecase(authRepository);
  });

  const user = User(id: '1', email: 'im@gmail', name: 'name');
  test('should call logIn method from repository and return user when success', () async {
    // arrange
    when(authRepository.logIn(email: 'im@gmail', password: 'passowrd'))
        .thenAnswer((_) async => const Right(user));
    // act
    final result = await logInUseCase(LogInParams(email: 'im@gmail', password: 'passowrd'));
    // assert
    verify(authRepository.logIn(email: 'im@gmail', password: 'passowrd'));
    expect(result, const Right(user));
  });
}