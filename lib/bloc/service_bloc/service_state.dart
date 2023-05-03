part of 'service_bloc.dart';

abstract class ServiceState {}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {
  ServiceLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class ServiceLoaded extends ServiceState {
  ServiceLoaded({
    required this.services,
  });

  final List<Services> services;

  List<Object?> get props => [services];
}

class ServiceLoadingFailure extends ServiceState {
  ServiceLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}
