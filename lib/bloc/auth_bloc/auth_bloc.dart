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
        debugPrint(e.toString());
      }
    });
  }

  DateTime _parseDateWithDayAndTime(int dayIndex, String time) {
    final now = DateTime.now();
    int currentDayOfWeek = now.weekday;

    int daysToAdd = (7 + dayIndex - currentDayOfWeek) % 7;
    final date = now.add(Duration(days: daysToAdd));

    final dateTimeString = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T$time';
    DateTime parsedDateTime = DateTime.parse(dateTimeString);
    parsedDateTime = parsedDateTime.subtract(const Duration(minutes: 5));
    return parsedDateTime;
  }

  Future notification() async {
    final params = await authRepo.initParams();
    for (var index = 0; index < params['data'].length; index++) {
      var item = params['data'][index];
      if (item['start_at'] != null) {
        try {
          final startDateTime = _parseDateWithDayAndTime(index, item['start_at']);
          await NotificationService().scheduleNotification(
            scheduledNotificationDateTime: startDateTime,
            title: 'Важно отметиться',
            body: 'Не забудьте отметиться о приходе на работу!',
            id: index,
          );
        } catch (e) {
          debugPrint('Ошибка при выполнении функции для start_at: $e');
        }
      }

      if (item['end_at'] != null) {
        try {
          final endDateTime = _parseDateWithDayAndTime(index, item['end_at']);
          await NotificationService().scheduleNotification(
            scheduledNotificationDateTime: endDateTime,
            title: 'Важно отметиться!',
            body: 'Не забудьте отметиться об уходе с работы!',
            id: (index + params['data'].length) as int,
          );
        } catch (e) {
          debugPrint('Ошибка при выполнении функции для end_at: $e');
        }
      }
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
