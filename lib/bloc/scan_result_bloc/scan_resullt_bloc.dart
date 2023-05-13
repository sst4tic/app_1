import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/scan_result_bloc/scan_result_repo.dart';

part 'scan_resullt_event.dart';
part 'scan_resullt_state.dart';

class ScanResultBloc extends Bloc<ScanResultEvent, ScanResultState> {
  ScanResultBloc() : super(ScanResultInitial()) {
    final scanResultRepo = ScanResultRepo();
    on<CheckScanResult>((event, emit) async {
      if(state is! ScanResultLoading) {
        emit(ScanResultLoading());
        // try {
          final result = await scanResultRepo.getScanResult(event.code);
          if (result.data.type == 'invoice') {
            emit(ScanResultInvoice(id: result.data.id!, invoiceId: result.data.invoiceId ?? ''));
          } else if (result.data.type == 'product') {
            emit(ScanResultProduct(id: result.data.productId!));
          }
      //   } catch (e) {
      //     emit(ScanResultLoadingFailure(exception: e));
      // }
      }
    });
  }
}
