part of 'multi_scan_bloc.dart';

abstract class MultiScanState {}

class MultiScanInitial extends MultiScanState {}

class MultiScanLoading extends MultiScanState {}

class MultiScanLoaded extends MultiScanState {
  final List<MultiScanModel>? data;

  MultiScanLoaded({this.data});

  List<Object?> get props => [data];
}

class MultiScanError extends MultiScanState {
  MultiScanError({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}
