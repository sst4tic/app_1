part of 'scanner_bloc.dart';

abstract class ScannerEvent {}

class ScannerInitialEvent extends ScannerEvent {}

class ScannerScanEvent extends ScannerEvent {
  ScannerScanEvent({
    required this.barcode,
  });

  final String barcode;

  List<Object?> get props => [barcode];
}

