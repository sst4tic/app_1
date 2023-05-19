import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yiwucloud/bloc/sales_details_bloc/sales_details_repo.dart';
import '../../util/sales_details_model.dart';

part 'sales_details_event.dart';

part 'sales_details_state.dart';

class SalesDetailsBloc extends Bloc<SalesDetailsEvent, SalesDetailsState> {
  SalesDetailsBloc() : super(SalesDetailsInitial()) {
    final salesDetailsRepo = SalesDetailsRepo();
    on<LoadSalesDetails>((event, emit) async {
      try {
        if (state is! SalesDetailsLoading) {
          emit(SalesDetailsLoading());
          final salesDetails =
              await salesDetailsRepo.loadSalesDetails(id: event.id);
          emit(SalesDetailsLoaded(salesDetails: salesDetails));
        }
      } catch (e) {
        emit(SalesDetailsLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<MovingRedirectionEvent>((event, emit) async {
      event.context.loaderOverlay.show();
      final redirection = await salesDetailsRepo.movingRedirection(
          id: event.id, act: event.act);
      final salesDetails =
          await salesDetailsRepo.loadSalesDetails(id: event.id);
      event.context.loaderOverlay.hide();
      if (redirection['success']) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: event.context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Успешно'),
                content: Text(redirection['message']),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      add(LoadSalesDetails(id: event.id));
                    },
                    child: const Text('Ок'),
                  )
                ],
              );
            });
        emit(SalesDetailsLoaded(salesDetails: salesDetails));
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
            context: event.context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Произошла ошибка'),
                content: Text(redirection['message']),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ок'),
                  )
                ],
              );
            });
      }
    });
    on<ChangeBoxQty>((event, emit) async {
      var qtyController = TextEditingController();
      var qty = await showCupertinoDialog(
        context: event.context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Укажите количество мест'),
            ),
            content: CupertinoTextField(
              controller: qtyController,
              // controller: passwordController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              placeholder: 'Введите число',
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Отмена'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: const Text('Подтвердить'),
                onPressed: () {
                  Navigator.of(context).pop(qtyController.text);
                },
              ),
            ],
          );
        },
      );
      if (qty != null) {
        event.context.loaderOverlay.show();
        final changeBoxQty = await salesDetailsRepo.changeBoxQty(
            id: event.id, boxQty: qtyController.text);
        final salesDetails =
            await salesDetailsRepo.loadSalesDetails(id: event.id);
        event.context.loaderOverlay.hide();
        if (changeBoxQty['success']) {
          // ignore: use_build_context_synchronously
          showDialog(
              context: event.context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Успешно'),
                  content: Text(changeBoxQty['message']),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        add(LoadSalesDetails(id: event.id));
                      },
                      child: const Text('Ок'),
                    )
                  ],
                );
              });
          emit(SalesDetailsLoaded(salesDetails: salesDetails));
        } else {
          // ignore: use_build_context_synchronously
          showDialog(
              context: event.context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Произошла ошибка'),
                  content: Text(changeBoxQty['message']),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ок'),
                    )
                  ],
                );
              });
        }
      }
    });
  }
}