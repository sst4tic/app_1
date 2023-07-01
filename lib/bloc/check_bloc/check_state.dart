part of 'check_bloc.dart';

abstract class CheckState {}

class CheckInitial extends CheckState {}

class CheckLoading extends CheckState {
  CheckLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class CheckLoaded extends CheckState {
  CheckLoaded({
    required this.check,
  });

  final WorkpaceModel check;

  List<Object?> get props => [check];
}

class CheckLoadingFailure extends CheckState {
  CheckLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}

