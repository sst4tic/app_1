import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/util/function_class.dart';

import '../../util/box_scan_model.dart';
import '../../util/invoice_scan_model.dart';
import 'invoice_scanner_repo.dart';

part 'invoice_scanner_event.dart';

part 'invoice_scanner_state.dart';

class InvoiceScannerBloc
    extends Bloc<InvoiceScannerEvent, InvoiceScannerState> {
  InvoiceScannerBloc() : super(InvoiceScannerInitial()) {
    final invoiceScannerRepo = InvoiceScannerRepo();
    on<LoadScanData>((event, emit) async {
      try {
        if (state is! InvoiceScannerLoading) {
          emit(InvoiceScannerLoading());
          final data = await invoiceScannerRepo.loadData(id: event.id);
          if (data['type'] == 'product') {
            final invoices = data['data']
                .map<InvoiceScanModel>(
                    (json) => InvoiceScanModel.fromJson(json))
                .toList();
            emit(InvoiceScannerLoaded(products: invoices, type: data['type']));
          } else {
            final box = BoxScanModel.fromJson(data['data']);
            emit(InvoiceScannerLoaded(box: box, type: data['type']));
          }
        }
      } catch (e) {
        emit(InvoiceScannerError(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    // for scan event
    on<InvoiceScanEvent>((event, emit) async {
      final scanData = await invoiceScannerRepo.invoiceScan(
          id: event.id, barcode: event.barcode);
      final data = await invoiceScannerRepo.loadData(id: event.id);
      try {
        if (scanData['success']) {
          AudioPlayer().play(AssetSource('sounds/success-sound.mp3'));
          // ignore: use_build_context_synchronously
          Func().showSnackbar(event.context, scanData['message'], true);
          if (data['type'] == 'product') {
            final invoices = data['data']
                .map<InvoiceScanModel>(
                    (json) => InvoiceScanModel.fromJson(json))
                .toList();
            emit(InvoiceScannerLoaded(products: invoices, type: data['type']));
          } else {
            final box = BoxScanModel.fromJson(data['data']);
            emit(InvoiceScannerLoaded(box: box, type: data['type']));
          }
        } else {
          AudioPlayer().play(AssetSource('sounds/fail-sound.mp3'));
          // ignore: use_build_context_synchronously
          Func().showSnackbar(event.context, scanData['message'], false);
        }
      } catch (e) {
        emit(InvoiceScannerError(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    // for manual input event
    on<InvoiceInputEvent>((event, emit) {
      showCupertinoDialog(
        context: event.context,
        builder: (BuildContext context) {
          final barcodeController = TextEditingController();
          final placeController = TextEditingController();
          placeController.text = '1';
          return CupertinoAlertDialog(
            title: const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Ввести в ручную'),
            ),
            content:
            event.type == 'product' ? CupertinoTextField(
              controller: barcodeController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              placeholder: 'Введите число',
            ) : Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    controller: barcodeController,
                    placeholder: 'Введите баркод',
                  ),
                ),
                const Text('- M -'),
                Expanded(
                  child: CupertinoTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    controller: placeController,
                    placeholder: 'Введите количество мест',
                  ),
                ),
              ],
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
                  Navigator.pop(context);
                  add(InvoiceScanEvent(
                      id: event.id,
                      barcode: event.type == 'product' ?  barcodeController.text : '${barcodeController.text}-M-${placeController.text}',
                      context: event.context));
                },
              ),
            ],
          );
        },
      );
    });
    // for button +/- event
    on<InvoiceScanQtyEvent>((event, emit) async {
      final qty = await invoiceScannerRepo.invoiceScanQty(
          id: event.id, barcode: event.barcode, qty: event.qty);
      final data = await invoiceScannerRepo.loadData(id: event.id);
      final invoices = data['data']
          .map<InvoiceScanModel>((json) => InvoiceScanModel.fromJson(json))
          .toList();
      // final box = BoxScanModel.fromJson(data['data'] ?? {});
      if (qty['success']) {
        HapticFeedback.mediumImpact();
        AudioPlayer().play(AssetSource('sounds/success-sound.mp3'));
        // ignore: use_build_context_synchronously
        Func().showSnackbar(event.context, qty['message'], true);
        emit(InvoiceScannerLoaded(products: invoices, type: data['type']));
      } else {
        HapticFeedback.mediumImpact();
        AudioPlayer().play(AssetSource('sounds/fail-sound.mp3'));
        // ignore: use_build_context_synchronously
        Func().showSnackbar(event.context, qty['message'], false);
      }
    });
    on<InvoiceScanInputQtyEvent>((event, emit) {
      showCupertinoDialog(
        context: event.context,
        builder: (BuildContext context) {
          final qtyController = TextEditingController();
          qtyController.text = event.qty.toString();
          return CupertinoAlertDialog(
            title: const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Ввести в ручную'),
            ),
            content: CupertinoTextField(
              controller: qtyController,
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
                  Navigator.pop(context);
                  add(InvoiceScanQtyEvent(
                      id: event.id,
                      barcode: event.barcode,
                      context: event.context,
                      qty: qtyController.text));
                },
              ),
            ],
          );
        },
      );
    });

  }
}
