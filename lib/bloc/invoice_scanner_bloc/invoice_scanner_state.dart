part of 'invoice_scanner_bloc.dart';

abstract class InvoiceScannerState {}

class InvoiceScannerInitial extends InvoiceScannerState {}

class InvoiceScannerLoading extends InvoiceScannerState {}

class InvoiceScannerLoaded extends InvoiceScannerState {
  // final List<InvoiceScanModel> warehouseSalesModel;
  //
  // InvoiceScannerLoaded(this.warehouseSalesModel);

  final List<InvoiceScanModel>? products;
  final BoxScanModel? box;

  InvoiceScannerLoaded({this.products, this.box});

  List<Object?> get props => [products, box];
}

class InvoiceScannerError extends InvoiceScannerState {
  InvoiceScannerError({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}

