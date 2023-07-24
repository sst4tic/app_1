import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yiwucloud/bloc/moving_details_bloc/moving_details_repo.dart';

import '../../models /custom_dialogs_model.dart';
import '../../models /moving_details.dart';

part 'moving_details_event.dart';

part 'moving_details_state.dart';

class MovingDetailsBloc extends Bloc<MovingDetailsEvent, MovingDetailsState> {
  MovingDetailsBloc() : super(MovingDetailsInitial()) {
    final movingRepo = MovingDetailsRepo();
    on<LoadMovingDetails>((event, emit) async {
      try {
        if (state is! MovingDetailsLoading) {
          emit(MovingDetailsLoading());
          final movingDetails =
              await movingRepo.loadMovingDetails(id: event.id);
          emit(MovingDetailsLoaded(movingDetails: movingDetails));
        }
      } catch (e) {
        emit(MovingDetailsLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<MovingRedirectionEvent>((event, emit) async {
      try {
        event.context.loaderOverlay.show();
        final redirection =
            await movingRepo.movingRedirection(id: event.id, act: event.act);
        event.context.loaderOverlay.hide();
          // ignore: use_build_context_synchronously
          showDialog(
              context: event.context,
              builder: (context) {
                return CustomAlertDialog(
                  title: redirection['success'] ? 'Успешно' : 'Произошла ошибка',
                  content: Text(redirection['message']),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        redirection['success'] ? add(LoadMovingDetails(id: event.id)) : null;
                      },
                      child: const Text('Ок'),
                    )
                  ],
                );
              });
      } catch (e) {
        event.context.loaderOverlay.hide();
        // ignore: use_build_context_synchronously
        showDialog(
            context: event.context,
            builder: (context) {
              return CustomAlertDialog(
                title: 'Ошибка',
                content: Text(e.toString()),
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
      }
    });
    on<DefineCourierEvent>((event, emit) async {
      try {
        event.context.loaderOverlay.show();
        final redirection = await movingRepo.defineCourier(movingId: event.invoiceId, courierId: event.courierId);
        event.context.loaderOverlay.hide();
        // ignore: use_build_context_synchronously
        showDialog(
            context: event.context,
            builder: (context) {
              return CustomAlertDialog(
                title: redirection['success'] ? 'Успешно' : 'Произошла ошибка',
                content: Text(redirection['message']),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      redirection['success'] ? add(LoadMovingDetails(id: event.invoiceId)) : null;
                    },
                    child: const Text('Ок'),
                  )
                ],
              );
            });
      } catch (e) {
        event.context.loaderOverlay.hide();
        // ignore: use_build_context_synchronously
        showDialog(
            context: event.context,
            builder: (context) {
              return CustomAlertDialog(
                title: 'Ошибка',
                content: Text(e.toString()),
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
      }
    });
  }
}
