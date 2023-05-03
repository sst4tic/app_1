part of 'service_bloc.dart';

abstract class ServiceEvent {}

class LoadServices extends ServiceEvent {
  LoadServices({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}
