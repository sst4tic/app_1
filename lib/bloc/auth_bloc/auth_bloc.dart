import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import 'package:yiwucloud/util/constants.dart';
import 'package:yiwucloud/util/function_class.dart';
import 'package:yiwucloud/util/notification_service.dart';
import 'abstract_auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractAuth authRepo;
  late StreamSubscription _authenticationStatusSubscription;

  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    _checkAuthenticationStatus();
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
      if (response.data['success']) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('login', response.data['api_token']);
        Constants.USER_TOKEN = response.data['api_token'];
        authRepo.getFirebaseToken(false);
        emit(Authenticated(token: response.data['api_token']));
      } else {
        emit(Unauthenticated(token: ''));
      }
    });
    on<DeleteAccountEvent>((event, emit) async {
      try {
        showDialog(
            context: event.context,
            builder: (BuildContext context) {
              return CustomAlertDialog(
                title: "Удаление аккаунта",
                content: const Text("Вы действительно хотите удалить аккаунт?"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      final response = await authRepo.deleteAccount();
                      // ignore: use_build_context_synchronously
                      Func().showSnackbar(event.context, response['message'],
                          response['success']);
                      if (response['success'] == true) {
                        add(LoggedOut());
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Да'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Нет'),
                  ),
                ],
              );
            });
      } catch (e) {
        print(e);
      }
    });
  }

  DateTime _parseDate(String time) {
    DateTime now = DateTime.now();
    final date =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T$time';
    return DateTime.parse(date);
  }

  Future notification() async {
    final params = await authRepo.initParams();
    Constants.startAt = params['data']['start_at'] ?? '';
    Constants.endAt = params['data']['end_at'] ?? '';
    if (params['data']['start_at'] != null) {
      if (_parseDate(params['data']['start_at']).isAfter(DateTime.now()) &&
          _parseDate(params['data']['end_at']).isAfter(DateTime.now())) {
        await NotificationService().scheduleNotification(
          scheduledNotificationDateTime: _parseDate(params['data']['start_at']),
          title: 'Не забудьте отметиться',
          body: 'Не забудьте отметиться о приходе на работу!',
        );
      } else if (_parseDate(params['data']['start_at'])
              .isBefore(DateTime.now()) &&
          _parseDate(params['data']['end_at']).isAfter(DateTime.now())) {
        await NotificationService().scheduleNotification(
          scheduledNotificationDateTime: _parseDate(params['data']['end_at']),
          id: 2,
          title: 'Не забудьте отметиться',
          body: 'Не забудьте отметиться об уходе с работы!',
        );
      } else if (_parseDate(params['data']['start_at'])
              .isBefore(DateTime.now()) &&
          _parseDate(params['data']['end_at']).isBefore(DateTime.now())) {
        await NotificationService().scheduleNotification(
          scheduledNotificationDateTime: _parseDate(params['data']['start_at'])
              .add(const Duration(days: 1)),
          title: 'Не забудьте отметиться',
          body: 'Не забудьте отметиться о приходе на работу!',
        );
      }
      await NotificationService().scheduleNotification(
        scheduledNotificationDateTime: _parseDate(params['data']['start_at']),
        title: 'Не забудьте отметиться',
        body: 'Не забудьте отметиться о приходе на работу!',
      );
      await NotificationService().scheduleNotification(
        scheduledNotificationDateTime: _parseDate(params['data']['end_at']),
        id: 2,
        title: 'Не забудьте отметиться',
        body: 'Не забудьте отметиться об уходе с работы!',
      );
    }
  }

  void _checkAuthenticationStatus() async {
    final isAuthenticated = await authRepo.getToken();
    if (isAuthenticated.isNotEmpty) {
      Constants.USER_TOKEN = isAuthenticated;
      Constants.bearer = 'Bearer $isAuthenticated';
      add(LoggedIn(token: isAuthenticated));
      notification();
    } else {
      add(LoggedOut());
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
