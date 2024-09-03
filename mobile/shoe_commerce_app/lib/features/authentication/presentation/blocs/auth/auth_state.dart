part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class LoggedInState extends AuthState {}

final class SignedUpState extends AuthState {}

final class LoggedOutState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class LoadedUserState extends AuthState {
  final User user;

  const LoadedUserState(this.user);
}

final class AuthErrorState extends AuthState {
  final String message;
  const AuthErrorState(this.message);
}
