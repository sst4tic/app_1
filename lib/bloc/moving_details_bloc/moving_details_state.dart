part of 'moving_details_bloc.dart';

abstract class MovingDetailsState {}

class MovingDetailsInitial extends MovingDetailsState {}

class MovingDetailsLoading extends MovingDetailsState {
  MovingDetailsLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class MovingDetailsLoaded extends MovingDetailsState {
  MovingDetailsLoaded({
    required this.movingDetails,
  });

  final MovingDetailsModel movingDetails;

  List<Object?> get props => [movingDetails];
}

class MovingDetailsLoadingFailure extends MovingDetailsState {
  MovingDetailsLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}