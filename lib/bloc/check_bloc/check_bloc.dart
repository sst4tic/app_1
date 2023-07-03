import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/models%20/workpace_model.dart';
import '../../models /custom_dialogs_model.dart';
import 'check_repo.dart';

part 'check_event.dart';

part 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  CheckBloc() : super(CheckInitial()) {
    final checkRepo = CheckRepo();
    on<LoadCheck>((event, emit) async {
      try {
        if (state is! CheckLoading) {
          emit(CheckLoading());
          final check = await checkRepo.loadCheck();
          emit(CheckLoaded(check: check));
        }
      } catch (e) {
        emit(CheckLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<CheckLocationEvent>((event, emit) async {
      showDialog(
          context: event.context,
          builder: (context) {
            return CustomAlertDialog(
              title: 'Подтверждение',
              content: const Text('Вы действительно хотите отметиться?'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    final check = await checkRepo.workpacePostpone(
                        lat: event.lat.toString(),
                        lon: event.lon.toString(),
                        type: event.type);
                    // ignore: use_build_context_synchronously
                    showDialog(
                        context: event.context,
                        builder: (context) {
                          return check['success']
                              ? CustomAlertDialog(
                                  title: 'Успешно',
                                  content: Text(check['message']),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        add(LoadCheck());
                                      },
                                      child: const Text('Ок'),
                                    )
                                  ],
                                )
                              : CustomAlertDialog(
                                  title: 'Ошибка',
                                  content: Text(check['message']),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Ок'),
                                    )
                                  ],
                                );
                        });
                  },
                  child: const Text('Да'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text('Нет'),
                )
              ],
            );
          });
    });
  }
}
