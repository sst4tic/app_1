import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yiwucloud/util/constants.dart';
import 'package:yiwucloud/util/function_class.dart';

import 'abstract_auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractAuth authRepo;
  late StreamSubscription _authenticationStatusSubscription;

  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    _checkAuthenticationStatus();
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>((event, emit) {
      emit(Authenticated(token: event.token));
    });
    on<LoggedOut>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove('login');
      emit(Unauthenticated(token: ''));
      authRepo.getFirebaseToken(true);
    });
    on<LoginEvent>((event, emit) async {
      final response =
          await authRepo.login(event.email, event.password, event.context);
      Func().showSnackbar(
          event.context, response.data['message'], response.data['success']);
      if (response.data['success'] == true) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('login', response.data['api_token']);
        Constants.USER_TOKEN = response.data['api_token'];
        authRepo.getFirebaseToken(false);
        emit(Authenticated(token: response.data['api_token']));
      } else {
        emit(Unauthenticated(token: ''));
      }
    });
  }

  void _checkAuthenticationStatus() async {
    final isAuthenticated = await authRepo.getToken();
    if (isAuthenticated.isNotEmpty) {
      Constants.USER_TOKEN = isAuthenticated;
      Constants.bearer = 'Bearer $isAuthenticated';
      add(LoggedIn(token: isAuthenticated));
    } else {
      add(LoggedOut());
    }
    // _authenticationStatusSubscription =
    //     Stream.periodic(const Duration(seconds: 30)).listen((_) async {
    //   final isAuthenticated = await authRepo.getToken();
    //   if (isAuthenticated.isNotEmpty) {
    //     add(LoggedIn(token: isAuthenticated));
    //   } else {
    //     add(LoggedOut());
    //   }
    // });
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final isAuthenticated = await authRepo.getToken();
    if (isAuthenticated != '') {
      emit(Authenticated(token: isAuthenticated.toString()));
    } else {
      emit(Unauthenticated(token: isAuthenticated.toString()));
    }
  }
}
