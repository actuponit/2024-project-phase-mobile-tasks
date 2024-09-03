import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/authentication/domain/entities/entities.dart';
import 'package:ecommerce_app/features/authentication/domain/usecases/log_in_usecase.dart';
import 'package:ecommerce_app/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:ecommerce_app/features/authentication/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockLogInUsecase loginUsecase;
  late MockSignUpUsecase signUpUsecase;
  late MockLogOutUsecase logoutUsecase;
  late MockGetUserUsecase getUserUsecase;
  late AuthBloc authBloc;

  setUp(() {
    loginUsecase = MockLogInUsecase();
    signUpUsecase = MockSignUpUsecase();
    logoutUsecase = MockLogOutUsecase();
    getUserUsecase = MockGetUserUsecase();

    authBloc = AuthBloc(
      logInUsecase: loginUsecase,
      signUpUsecase: signUpUsecase,
      logOutUsecase: logoutUsecase,
      getUserUsecase: getUserUsecase,
    );
  });
 
  test('initial state is ProductInitial', () {
    expect(authBloc.state, AuthInitial());
  });

  const SERVER_FAILURE = 'Server Failure';
  group('login', (){

    blocTest<AuthBloc, AuthState>(
      'emits [Loading, LoggedInState] when LoginEvent is added if no failure',
      build: () {
        when(loginUsecase(LogInParams(email: 'email', password: 'password')))
          .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent('email', 'password')),
      expect: () => [
        AuthLoadingState(),
        LoggedInState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [Loading, AuthErrorState] when LoginEvent is added and there is a failure',
      build: () {
        when(loginUsecase(LogInParams(email: 'email', password: 'password')))
          .thenAnswer((_) async => const Left(ServerFailure(SERVER_FAILURE)));
        return authBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent('email', 'password')),
      expect: () => [
        AuthLoadingState(),
        const AuthErrorState(SERVER_FAILURE),
      ],
    );
  });
  group('signup', (){
    const user = User(name: 'name', email: 'email', id: 'id');
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, SignedUpState] when SignUpEvent is added if no failure',
      build: () {
        when(signUpUsecase(const SignUpParams(email: 'email', password: 'password', name: 'name')))
          .thenAnswer((_) async => const Right(user));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpEvent('email', 'password', 'name')),
      expect: () => [
        AuthLoadingState(),
        SignedUpState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthErrorState] when LoginEvent is added and there is a failure',
      build: () {
        when(signUpUsecase(const SignUpParams(name:'name', email: 'email', password: 'password')))
          .thenAnswer((_) async => const Left(ServerFailure(SERVER_FAILURE)));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpEvent('email', 'password', 'name')),
      expect: () => [
        AuthLoadingState(),
        const AuthErrorState(SERVER_FAILURE),
      ],
    );
  });
  group('getuser', (){
    const user = User(name: 'name', email: 'email', id: 'id');
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, UserLoadedState] when GetUserEvent is added if no failure',
      build: () {
        when(getUserUsecase(NoParams()))
          .thenAnswer((_) async => const Right(user));
        return authBloc;
      },
      act: (bloc) => bloc.add(GetUserEvent()),
      expect: () => [
        AuthLoadingState(),
        const LoadedUserState(user),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthErrorState] when GetUserEvent is added and there is a failure',
      build: () {
        when(getUserUsecase(NoParams()))
          .thenAnswer((_) async => const Left(ServerFailure(SERVER_FAILURE)));
        return authBloc;
      },
      act: (bloc) => bloc.add(GetUserEvent()),
      expect: () => [
        AuthLoadingState(),
        const AuthErrorState(SERVER_FAILURE),
      ],
    );
  });

  group('logout', (){
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, LogedOutState] when LogOutEvent is added if no failure',
      build: () {
        when(logoutUsecase(NoParams()))
          .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogOutEvent()),
      expect: () => [
        AuthLoadingState(),
        LoggedOutState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthErrorState] when LogOutEvent is added and there is a failure',
      build: () {
        when(logoutUsecase(NoParams()))
          .thenAnswer((_) async => const Left(ServerFailure(SERVER_FAILURE)));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogOutEvent()),
      expect: () => [
        AuthLoadingState(),
        const AuthErrorState(SERVER_FAILURE),
      ],
    );
  });
}