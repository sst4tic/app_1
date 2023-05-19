part of 'scanner_bloc.dart';

abstract class ScannerState {}

class ScannerInitial extends ScannerState {
  ScannerInitial({
    required this.barcodeList,
  });

  final List<BarcodeModel> barcodeList;

  List<Object?> get props => barcodeList;
}

