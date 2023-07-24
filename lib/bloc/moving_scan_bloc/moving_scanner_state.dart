part of 'moving_scanner_bloc.dart';

abstract class MovingScannerState {}

class MovingScannerInitial extends MovingScannerState {}

class MovingScannerLoading extends MovingScannerState {}

class MovingScannerLoaded extends MovingScannerState {

  final List<MovingScanModel>? products;
  MovingScannerLoaded({this.products});

  List<Object?> get props => [products];
}

class MovingScannerError extends MovingScannerState {
  MovingScannerError({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}
