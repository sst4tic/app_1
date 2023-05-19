import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/util/barcode_model.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(ScannerInitial(barcodeList: [])) {
    on<ScannerScanEvent>((event, emit) {
    });
  }
}
