part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;

  LoggedIn({required this.token});
}

class LoggedOut extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password, required this.context});
  List<Object> get props => [email, password, context];
}

class DeleteAccountEvent extends AuthEvent {
  final BuildContext context;

  DeleteAccountEvent({required this.context});
  List<Object> get props => [context];
}
