import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/get_user_usecase.dart';
import '../../../domain/usecases/log_in_usecase.dart';
import '../../../domain/usecases/log_out_usecase.dart';
import '../../../domain/usecases/sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogInUsecase logInUsecase;
  final SignUpUsecase signUpUsecase;
  final GetUserUsecase getUserUsecase;
  final LogOutUsecase logOutUsecase;

  AuthBloc({
    required this.getUserUsecase,
    required this.logInUsecase,
    required this.logOutUsecase,
    required this.signUpUsecase,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await logInUsecase(LogInParams(email: event.email, password: event.password));
      result.fold(
        (failure) {
          emit(AuthErrorState(failure.message));
        }, (_) {
          emit(LoggedInState());
        });
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await signUpUsecase(SignUpParams(email: event.email, password: event.password, name: event.name));
      result.fold(
        (failure) {
          emit(AuthErrorState(failure.message));
        }, (_) {
          emit(SignedUpState());
        });
    });

    on<LogOutEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await logOutUsecase(NoParams());
      result.fold(
        (failure) {
          emit(AuthErrorState(failure.message));
        }, (_) {
          emit(LoggedOutState());
        });
    });

    on<GetUserEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await getUserUsecase(NoParams());
      result.fold(
        (failure) {
          emit(AuthErrorState(failure.message));
        }, (user) {
          emit(LoadedUserState(user));
        });
    });
  }
}
