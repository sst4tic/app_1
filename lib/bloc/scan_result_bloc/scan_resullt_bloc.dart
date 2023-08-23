import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/scan_result_bloc/scan_result_repo.dart';

part 'scan_resullt_event.dart';

part 'scan_resullt_state.dart';

class ScanResultBloc extends Bloc<ScanResultEvent, ScanResultState> {
  ScanResultBloc() : super(ScanResultInitial()) {
    final scanResultRepo = ScanResultRepo();
    on<CheckScanResult>((event, emit) async {
      if (state is! ScanResultLoading) {
        emit(ScanResultLoading());
        try {
          final result = await scanResultRepo.getScanResult(event.code);
          if(result.success) {
            AudioPlayer().play(AssetSource('sounds/success-sound.mp3'),
                mode: PlayerMode.lowLatency
            );
          } else {
            AudioPlayer().play(AssetSource('sounds/fail-sound.mp3'),
                mode: PlayerMode.lowLatency
            );
          }
          if (result.data.type == 'invoice') {
            emit(ScanResultInvoice(
                id: result.data.id!, invoiceId: result.data.invoiceId ?? ''));
          } else if (result.data.type == 'product') {
            emit(ScanResultProduct(id: result.data.productId!));
          } else if (result.data.type == 'moving') {
            emit(ScanResultMoving(
                id: result.data.id!, movingId: result.data.movingId ?? ''));
          } else {
            emit(ScanResultLoadingFailure(exception: result.message));
          }
        } catch (e) {
          emit(ScanResultLoadingFailure(exception: e));
        }
      }
    });
  }
}
