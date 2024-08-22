import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/authentication/domain/usecases/log_out_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockAuthenticationRepository authRepository;
  late LogOutUsecase logOutUseCase;

  setUp(() {
    authRepository = MockAuthenticationRepository();
    logOutUseCase = LogOutUsecase(authRepository);
  });

  test('should call logOut method from repository', () async {
    // arrange
    when(authRepository.logOut()).thenAnswer((_) async => const Right(null));
    // act
    await logOutUseCase(NoParams());
    // assert
    verify(authRepository.logOut());
  });
}