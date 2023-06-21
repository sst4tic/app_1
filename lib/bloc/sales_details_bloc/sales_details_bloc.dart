import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yiwucloud/bloc/sales_details_bloc/sales_details_repo.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import '../../models /postpone_dialog_model.dart';
import '../../util/sales_details_model.dart';

part 'sales_details_event.dart';

part 'sales_details_state.dart';

class SalesDetailsBloc extends Bloc<SalesDetailsEvent, SalesDetailsState> {
  SalesDetailsBloc() : super(SalesDetailsInitial()) {
    final salesDetailsRepo = SalesDetailsRepo();
    on<LoadSalesDetails>((event, emit) async {
      // try {
        if (state is! SalesDetailsLoading) {
          emit(SalesDetailsLoading());
          final salesDetails =
              await salesDetailsRepo.loadSalesDetails(id: event.id);
          emit(SalesDetailsLoaded(salesDetails: salesDetails));
        }
      // } catch (e) {
      //   emit(SalesDetailsLoadingFailure(exception: e));
      // } finally {
      //   event.completer?.complete();
      // }
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
              return CustomAlertDialog(
                title: 'Успешно',
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
              return CustomAlertDialog(
                title: 'Произошла ошибка',
                content: Text(redirection['message']),
                actions: [
                  CustomDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Ок',
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
          return CustomAlertDialog(
            title: 'Укажите количество мест',
            content: CustomTextField(
              controller: qtyController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              placeholder: 'Введите число',
            ),
            actions: [
              CustomDialogAction(
                text: 'Отмена',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomDialogAction(
                text: 'Подтвердить',
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
                return CustomAlertDialog(
                  title: 'Успешно',
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
                return CustomAlertDialog(
                  title: 'Произошла ошибка',
                  content: Text(changeBoxQty['message']),
                  actions: [
                    CustomDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Ок',
                    )
                  ],
                );
              });
        }
      }
    });
    on<PostponeEvent>((event, emit) async {
      final reasons = await salesDetailsRepo.getPostponeReasons();
      // ignore: use_build_context_synchronously
      showDialog(
              context: event.context,
              builder: (context) {
                return PostponeDialog(
                  reasons: reasons,
                  invoiceId: event.id,
                );
              })
          .then((value) => add(PostponeSendEvent(
              id: event.id, context: event.context, reasonId: value)));
    });

    on<PostponeSendEvent>((event, emit) async {
      var resp = await salesDetailsRepo.sendPostpone(
          reasonId: event.reasonId, id: event.id);
      if (resp['success']) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: event.context,
            builder: (context) {
              return CustomAlertDialog(
                title: 'Успешно!',
                content: Text(resp['message']),
                actions: [
                  CustomDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Ок',
                  )
                ],
              );
            });
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
            context: event.context,
            builder: (context) {
              return CustomAlertDialog(
                title: 'Произошла ошибка',
                content: Text(resp['message']),
                actions: [
                  CustomDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Ок',
                  )
                ],
              );
            });
      }
    });

    on<DefineCourierEvent>((event, emit) async {
      event.context.loaderOverlay.show();
      final resp = await salesDetailsRepo.defineCourier(
          invoiceId: event.invoiceId, courierId: event.courierId);
      event.context.loaderOverlay.hide();
      if (resp['success']) {
        // ignore: use_build_context_synchronously
        showDialog(
                context: event.context,
                builder: (context) {
                  return CustomAlertDialog(
                    title: 'Успешно!',
                    content: Text(resp['message']),
                    actions: [
                      CustomDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                          add(LoadSalesDetails(id: event.invoiceId));
                        },
                        text: 'Ок',
                      )
                    ],
                  );
                });
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
            context: event.context,
            builder: (context) {
              return CustomAlertDialog(
                title: 'Произошла ошибка',
                content: Text(resp['message']),
                actions: [
                  CustomDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Ок',
                  )
                ],
              );
            });
      }
    });
  }
}
