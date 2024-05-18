part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoaded extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}
