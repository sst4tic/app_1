part of 'scan_resullt_bloc.dart';

abstract class ScanResultState {}

class ScanResultInitial extends ScanResultState {}

class ScanResultLoading extends ScanResultState {
  ScanResultLoading({
    this.completer,

  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class ScanResultInvoice extends ScanResultState {
  ScanResultInvoice({
    required this.id,
    required this.invoiceId,
  });

  final int id;
  final String invoiceId;


  List<Object?> get props => [id, invoiceId];
}

class ScanResultProduct extends ScanResultState {
  ScanResultProduct({
    required this.id,
  });

  final int id;


  List<Object?> get props => [id];
}

class ScanResultLoadingFailure extends ScanResultState {
  ScanResultLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}