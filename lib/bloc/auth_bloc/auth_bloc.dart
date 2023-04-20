import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/util/function_class.dart';

import 'abstract_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractAuth authRepo;
  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    _checkAuthenticationStatus();
    on<LoggedIn>((event, emit) {
      emit(Authenticated(token: event.token));
    });
    on<LoggedOut>((event, emit) {
      emit(Unauthenticated(token: ''));
    });
    on<LoginEvent>((event, emit) async {
      final response = await authRepo.login(event.email, event.password, event.context);
      print(response.data['success']);
      Func().showSnackbar(event.context, response.data['message'], response.data['success']);
      if (response.data['success'] == true) {
        emit(Authenticated(token: response.data['api_token']));
      } else {
        emit(Unauthenticated(token: ''));
      }
    });
  }

  Future<void> _checkAuthenticationStatus() async {
    final isAuthenticated = await authRepo.getToken();
    print(isAuthenticated);
    if (isAuthenticated != '') {
      add(LoggedIn(token: isAuthenticated));
    } else {
      add(LoggedOut());
    }
  }

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final isAuthenticated = await authRepo.getToken();
      if (isAuthenticated != '') {
        yield Authenticated(token: isAuthenticated.toString());
      } else {
        yield Unauthenticated(token: isAuthenticated.toString());
      }
    } else if (event is LoggedIn) {
      yield Authenticated(token: event.token);
    } else if (event is LoggedOut) {
      yield Unauthenticated(token: '');
    } else if (event is LoginEvent) {
      final data = await authRepo.login(event.email, event.password, event.context);
      if (data['api_token'] != '') {
        yield Authenticated(token: data['api_token']);
      } else {
        yield Unauthenticated(token: 'token');
      }
    }
  }
}
