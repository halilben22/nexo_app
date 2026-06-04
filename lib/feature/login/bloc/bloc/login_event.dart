part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginWithGoogle extends LoginEvent {}

class SignOut extends LoginEvent {}
