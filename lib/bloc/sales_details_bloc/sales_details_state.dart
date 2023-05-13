part of 'sales_details_bloc.dart';

abstract class SalesDetailsState {}

class SalesDetailsInitial extends SalesDetailsState {}

class SalesDetailsLoading extends SalesDetailsState {
  SalesDetailsLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class SalesDetailsLoaded extends SalesDetailsState {
  SalesDetailsLoaded({
    required this.salesDetails,
  });

  final SalesDetailsModel salesDetails;

  List<Object?> get props => [salesDetails];
}

class SalesDetailsLoadingFailure extends SalesDetailsState {
  SalesDetailsLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}