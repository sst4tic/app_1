part of 'multi_scan_bloc.dart';

abstract class MultiScanEvent {}

class LoadScanData extends MultiScanEvent {
  LoadScanData({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class ScanEvent extends MultiScanEvent {
  ScanEvent({
    this.completer,
    required this.context,
    required this.barcode,
  });

  final Completer? completer;
  final BuildContext context;
  final String barcode;

  List<Object?> get props => [completer, barcode];
}

class SubmitEvent extends MultiScanEvent {
  SubmitEvent({
    this.completer,
    required this.context,
  });

  final Completer? completer;
  final BuildContext context;

  List<Object?> get props => [completer];
}

class DeleteEvent extends MultiScanEvent {
  DeleteEvent({
    this.completer,
    required this.context,
    required this.invoiceId,
  });

  final Completer? completer;
  final BuildContext context;
  final int invoiceId;

  List<Object?> get props => [completer, invoiceId];
}