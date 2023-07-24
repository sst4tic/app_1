import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models /custom_dialogs_model.dart';
import '../../models /moving_scan_model.dart';
import '../../util/function_class.dart';
import 'moving_scanner_repo.dart';

part 'moving_scanner_event.dart';
part 'moving_scanner_state.dart';

class MovingScannerBloc extends Bloc<MovingScannerEvent, MovingScannerState> {
  MovingScannerBloc() : super(MovingScannerInitial()) {
    final movingScannerRepo = MovingScannerRepo();
    on<LoadScanData>((event, emit) async {
      try {
        if (state is! MovingScannerLoading) {
          emit(MovingScannerLoading());
          final data = await movingScannerRepo.loadData(id: event.id);
            final movings = data['data']
                .map<MovingScanModel>(
                    (json) => MovingScanModel.fromJson(json))
                .toList();
            emit(MovingScannerLoaded(products: movings));
        }
      } catch (e) {
        emit(MovingScannerError(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    // for scan event
    on<MovingScanEvent>((event, emit) async {
      final scanData = await movingScannerRepo.movingScan(
          id: event.id, barcode: event.barcode);
      final data = await movingScannerRepo.loadData(id: event.id);
      try {
        if (scanData['success']) {
          AudioPlayer().play(AssetSource('sounds/success-sound.mp3'), mode: PlayerMode.lowLatency);
          // ignore: use_build_context_synchronously
          Func().showSnackbar(event.context, scanData['message'], true);
            final movings = data['data']
                .map<MovingScanModel>(
                    (json) => MovingScanModel.fromJson(json))
                .toList();
            emit(MovingScannerLoaded(products: movings));
        } else {
          AudioPlayer().play(AssetSource('sounds/fail-sound.mp3'),
              mode: PlayerMode.lowLatency);
          // ignore: use_build_context_synchronously
          Func().showSnackbar(event.context, scanData['message'], false);
        }
      } catch (e) {
        emit(MovingScannerError(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    // for manual input event
    on<MovingInputEvent>((event, emit) {
      showCupertinoDialog(
        context: event.context,
        builder: (BuildContext context) {
          final barcodeController = TextEditingController();
          return CustomAlertDialog(
            title: 'Ввести в ручную',
            content: CustomTextField(
              controller: barcodeController,
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
                  Navigator.pop(context);
                  add(MovingScanEvent(
                      id: event.id,
                      barcode: barcodeController.text,
                      context: event.context));
                },
              ),
            ],
          );
        },
      );
    });
    // for button +/- event
    on<MovingScanQtyEvent>((event, emit) async {
      final qty = await movingScannerRepo.movingScanQty(
          id: event.id, barcode: event.barcode, qty: event.qty);
      final data = await movingScannerRepo.loadData(id: event.id);
      final movings = data['data']
          .map<MovingScanModel>((json) => MovingScanModel.fromJson(json))
          .toList();
      if (qty['success']) {
        AudioPlayer().play(AssetSource('sounds/success-sound.mp3'),
            mode: PlayerMode.lowLatency);
        HapticFeedback.mediumImpact();
        // ignore: use_build_context_synchronously
        Func().showSnackbar(event.context, qty['message'], true);
        emit(MovingScannerLoaded(products: movings));
      } else {
        AudioPlayer().play(AssetSource('sounds/fail-sound.mp3'),
            mode: PlayerMode.lowLatency);
        HapticFeedback.mediumImpact();
        // ignore: use_build_context_synchronously
        Func().showSnackbar(event.context, qty['message'], false);
      }
    });
    on<MovingScanInputQtyEvent>((event, emit) {
      showCupertinoDialog(
        context: event.context,
        builder: (BuildContext context) {
          final qtyController = TextEditingController();
          qtyController.text = event.qty.toString();
          return CustomAlertDialog(
              title: 'Ввести в ручную',
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
                    Navigator.pop(context);
                    add(MovingScanQtyEvent(
                        id: event.id,
                        barcode: event.barcode,
                        context: event.context,
                        qty: qtyController.text));
                  },
                ),
              ]);
        },
      );
    });
  }
}