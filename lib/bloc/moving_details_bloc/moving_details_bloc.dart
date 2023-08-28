import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
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
        final position = event.act == 'wareHouseComplete' ? await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high) : null;
        event.context.loaderOverlay.show();
        final redirection =
            await movingRepo.movingRedirection(id: event.id, act: event.act, lat: position?.latitude, lon: position?.longitude);
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
                      redirection['success']
                          ? add(LoadMovingDetails(id: event.id))
                          : null;
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

    on<ChangeBoxQty>((event, emit) async {
      var qtyController = TextEditingController();
      var status = event.select?.initialValue;
      var qty = await showCupertinoDialog(
        context: event.context,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: StatefulBuilder(builder: (context, innerSetState) {
              return CustomAlertDialog(
                title: 'Укажите количество мест',
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 8.h),
                    event.select != null
                        ? DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              isExpanded: true,
                              buttonStyleData: ButtonStyleData(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  padding: REdgeInsets.all(8)),
                              value: event.select!.initialValue,
                              items: event.select!.data
                                  .map((e) => DropdownMenuItem(
                                        value: e.value,
                                        child: Text(e.text),
                                      ))
                                  .toList(),
                              style: const TextStyle(fontSize: 12, color: Colors.black),
                              onChanged: (value) {
                                innerSetState(() {
                                  event.select?.initialValue = value as int;
                                  status = value as int;
                                });
                              },
                            ),
                        )
                        : Container(),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: qtyController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      placeholder: 'Введите число',
                    ),
                  ],
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
            }),
          );
        },
      );
      if (qty != null) {
        event.context.loaderOverlay.show();
        final changeBoxQty = await movingRepo.changeBoxQty(
            id: event.id, qty: qtyController.text, status: status);
        final movingDetails = await movingRepo.loadMovingDetails(id: event.id);
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
                        add(LoadMovingDetails(id: event.id));
                      },
                      child: const Text('Ок'),
                    )
                  ],
                );
              });
          emit(MovingDetailsLoaded(movingDetails: movingDetails));
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

    on<DefineCourierEvent>((event, emit) async {
      try {
        event.context.loaderOverlay.show();
        final redirection = await movingRepo.defineCourier(
            movingId: event.invoiceId, courierId: event.courierId);
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
                      redirection['success']
                          ? add(LoadMovingDetails(id: event.invoiceId))
                          : null;
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
