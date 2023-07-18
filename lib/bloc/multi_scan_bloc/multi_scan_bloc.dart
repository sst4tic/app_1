import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yiwucloud/bloc/invoice_scanner_bloc/invoice_scanner_repo.dart';
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

    Future completeList(String id) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=invoices_complete_array&id=$id';
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
          if (index != -1) {
            if (data[index].qty == data[index].qtyScanned) {
              AudioPlayer().play(AssetSource('sounds/fail-sound.mp3'),
                  mode: PlayerMode.lowLatency);
              Func().showSnackbar(
                  event.context, 'Баркод уже отсканирован', false);
              return;
            }
            final resp = await InvoiceScannerRepo()
                .invoiceScan(id: data[index].invoiceId, barcode: event.barcode);
            if (resp['success']) {
              AudioPlayer().play(AssetSource('sounds/success-sound.mp3'),
                  mode: PlayerMode.lowLatency);
              data[index].qtyScanned = data[index].qtyScanned + 1;
              emit(MultiScanLoaded(data: data));
            } else {
              Func().showSnackbar(event.context, resp['message'], false);
              AudioPlayer().play(AssetSource('sounds/fail-sound.mp3'));
            }
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
          final dataScanned = data!
              .where((element) => element.qty == element.qtyScanned)
              .toList();
          final invoiceIdList = data
              .where((element) => element.qty == element.qtyScanned)
              .map((e) => e.invoiceId)
              .join(',')
              .toString();
          final scannedList = data.map(
              (e) => e.qtyScanned != 0 && e.qtyScanned != e.qty ? true : false);
          if (invoiceIdList.isEmpty) {
            navKey.currentContext!.loaderOverlay.hide();
            Func().showSnackbar(
                event.context, 'Нет отсканированных накладных', false);
            return;
          } else if (scannedList.contains(true)) {
            navKey.currentContext!.loaderOverlay.hide();
            String message = 'Накладные не отсканированы полностью:';
            for (var index = 0; index < data.length; index++) {
              if (scannedList.elementAt(index)) {
                message += '\n${data[index].barcode}';
              }
            }
            Func().showSnackbar(event.context, message, false);
            return;
          } else {
            final redirectionResp = await completeList(invoiceIdList);
            navKey.currentContext!.loaderOverlay.hide();
            emit(MultiScanLoaded(data: await getScan()));
            // ignore: use_build_context_synchronously
            showDialog(
                context: event.context,
                builder: (context) {
                  return CustomAlertDialog(
                    title: redirectionResp['success']
                        ? 'Успешно'
                        : 'Произошла ошибка',
                    content: redirectionResp['success']
                        ? Text('Отсканированно ${dataScanned.length} накладных')
                        : Text('${redirectionResp['message']}'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ок'))
                    ],
                  );
                });
          }
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
