part of 'arrival_details_bloc.dart';

abstract class ArrivalDetailsState {}

class ArrivalDetailsInitial extends ArrivalDetailsState {}

class ArrivalDetailsLoading extends ArrivalDetailsState {
  ArrivalDetailsLoading({this.completer});

  final Completer? completer;
}

class ArrivalDetailsLoaded extends ArrivalDetailsState {
  final ArrivalDetailsModel arrivalDetails;

  ArrivalDetailsLoaded({required this.arrivalDetails});
}

class ArrivalDetailsError extends ArrivalDetailsState {
  final Object e;

  ArrivalDetailsError({required this.e});
}