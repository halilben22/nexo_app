part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

abstract class LoginActionState extends LoginState {
  final String message;
  LoginActionState(this.message);
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginActionState {
  LoginSuccess(super.message);
}

final class LoginFailure extends LoginActionState {
  LoginFailure(super.message);
}

final class SigningOut extends LoginState {}

final class SignedOutSuccess extends LoginActionState {
  SignedOutSuccess(super.message);
}

final class SignedOutFailure extends LoginActionState {
  SignedOutFailure(super.message);
}
