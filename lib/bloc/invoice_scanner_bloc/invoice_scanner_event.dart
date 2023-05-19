part of 'invoice_scanner_bloc.dart';

abstract class InvoiceScannerEvent {}

class LoadScanData extends InvoiceScannerEvent {
  LoadScanData({
    this.completer,
    required this.id,
  });

  final Completer? completer;
  final int id;

  List<Object?> get props => [completer, id];
}

class InvoiceScanEvent extends InvoiceScannerEvent {
  InvoiceScanEvent({
    this.completer,
    required this.id,
    required this.context,
    required this.barcode,
  });

  final Completer? completer;
  final int id;
  final BuildContext context;
  final String barcode;

  List<Object?> get props => [completer, id, barcode];
}

class InvoiceInputEvent extends InvoiceScannerEvent {
  InvoiceInputEvent({
    this.completer,
    required this.id,
    required this.context,
  });

  final Completer? completer;
  final int id;
  final BuildContext context;

  List<Object?> get props => [completer, id];
}

class InvoiceScanQtyEvent extends InvoiceScannerEvent {
  InvoiceScanQtyEvent({
    this.completer,
    required this.id,
    required this.context,
    required this.barcode,
    required this.qty,
  });

  final Completer? completer;
  final int id;
  final BuildContext context;
  final String barcode;
  final qty;

  List<Object?> get props => [completer, id, barcode, qty];
}
class InvoiceScanInputQtyEvent extends InvoiceScannerEvent {
  InvoiceScanInputQtyEvent({
    this.completer,
    required this.id,
    required this.context,
    required this.barcode,
    required this.qty,
  });

  final Completer? completer;
  final int id;
  final BuildContext context;
  final String barcode;
  final qty;

  List<Object?> get props => [completer, id, barcode, qty];
}

