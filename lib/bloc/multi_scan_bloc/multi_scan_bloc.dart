import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yiwucloud/bloc/invoice_scanner_bloc/invoice_scanner_repo.dart';
import 'package:yiwucloud/bloc/sales_details_bloc/sales_details_repo.dart';
import 'package:yiwucloud/main.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import 'package:yiwucloud/models%20/multi_scan_model.dart';
import 'package:http/http.dart' as http;
import 'package:yiwucloud/util/function_class.dart';
import '../../util/constants.dart';

part 'multi_scan_event.dart';

part 'multi_scan_state.dart';

class MultiScanBloc extends Bloc<MultiScanEvent, MultiScanState> {
  MultiScanBloc() : super(MultiScanInitial()) {
    Future<List<MultiScanModel>> getScan() async {
      var url = '${Constants.API_URL_DOMAIN}action=multi_scan_boxes';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      return body['data']
          .map<MultiScanModel>((json) => MultiScanModel.fromJson(json))
          .toList();
    }

    Future deleteScan(invoiceId) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=reset_scan&invoice_id=$invoiceId';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      return body;
    }

    on<LoadScanData>((event, emit) async {
      try {
        if (state is! MultiScanLoading) {
          emit(MultiScanLoading());
          final data = await getScan();
          emit(MultiScanLoaded(data: data));
        }
      } catch (e) {
        emit(MultiScanError(exception: e.toString()));
      }
    });
    on<ScanEvent>((event, emit) async {
      try {
        if (state is! MultiScanLoading) {
          final data = (state as MultiScanLoaded).data;
          final index =
              data!.indexWhere((element) => element.barcode == event.barcode);
          final invoiceId = data[index].invoiceId;
          if (index != -1) {
            if (data[index].qty == data[index].qtyScanned) {
              AudioPlayer().play(AssetSource('sounds/fail-sound.mp3'),
                  mode: PlayerMode.lowLatency);
              Func().showSnackbar(
                  event.context, 'Баркод уже отсканирован', false);
              return;
            }
            AudioPlayer().play(AssetSource('sounds/success-sound.mp3'),
                mode: PlayerMode.lowLatency);
            data[index].qtyScanned = data[index].qtyScanned + 1;
            await InvoiceScannerRepo().invoiceScan(
                id: data[index].invoiceId, barcode: event.barcode);
            emit(MultiScanLoaded(data: data));
          }
        }
      } catch (e) {
        AudioPlayer().play(AssetSource('sounds/fail-sound.mp3'),
            mode: PlayerMode.lowLatency);
        Func().showSnackbar(event.context, 'Баркода нет в списке', false);
      }
    });
    on<SubmitEvent>((event, emit) async {
      try {
        navKey.currentContext!.loaderOverlay.show();
        if (state is! MultiScanLoading) {
          final data = (state as MultiScanLoaded).data;
          bool isSnackBarShown = false;
          for (var i = 0; i < data!.length; i++) {
            if (data[i].qty == data[i].qtyScanned) {
              final redirectionResp = await SalesDetailsRepo().movingRedirection(
                  id: data[i].invoiceId, act: 'wareHouseComplete');
              emit(MultiScanLoaded(data: await getScan()));
              if (!isSnackBarShown && redirectionResp['success']) {
                // ignore: use_build_context_synchronously
                showDialog(context: event.context, builder: (context) {
                  return CustomAlertDialog(
                    title: 'Успешно',
                    content: Text('Отсканированно ${data.length} накладных'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ок'))
                    ],
                  );
                });
                isSnackBarShown = true;
              }
            } else {
              if (!isSnackBarShown) {
                // ignore: use_build_context_synchronously
                Func().showSnackbar(
                    event.context,
                    '${data.where((element) => element.qty != element.qtyScanned).map((e) => e.barcode).toList().join(', ')} не отсканированы',
                    false);
                isSnackBarShown = true;
              }
            }
          }
          navKey.currentContext!.loaderOverlay.hide();
        }
      } catch (e) {
        emit(MultiScanError(exception: e.toString()));
      }
    });
    on<DeleteEvent>((event, emit) async {
      try {
        navKey.currentContext!.loaderOverlay.show();
        if (state is! MultiScanLoading) {
          final resp = await deleteScan(event.invoiceId);
          Func().showSnackbar(
              navKey.currentContext, resp['message'], resp['success']);
          resp['success'] ? emit(MultiScanLoaded(data: await getScan())) : null;
        }
        navKey.currentContext!.loaderOverlay.hide();
      } catch (e) {
        emit(MultiScanError(exception: e.toString()));
      }
    });
  }
}
