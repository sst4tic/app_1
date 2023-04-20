part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;

  LoggedIn({required this.token});
}

class LoggedOut extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final context;
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password, this.context});
  List<Object> get props => [email, password, context];
}
