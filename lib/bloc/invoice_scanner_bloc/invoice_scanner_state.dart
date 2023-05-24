part of 'invoice_scanner_bloc.dart';

abstract class InvoiceScannerState {}

class InvoiceScannerInitial extends InvoiceScannerState {}

class InvoiceScannerLoading extends InvoiceScannerState {}

class InvoiceScannerLoaded extends InvoiceScannerState {

  final List<InvoiceScanModel>? products;
  final BoxScanModel? box;
  final String type;
  InvoiceScannerLoaded({this.products, this.box, required this.type});

  List<Object?> get props => [products, box];
}

class InvoiceScannerError extends InvoiceScannerState {
  InvoiceScannerError({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}

