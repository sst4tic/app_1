part of 'service_bloc.dart';

abstract class ServiceEvent {}

class LoadServices extends ServiceEvent {
  LoadServices({
    this.completer,
    required this.id
  });

  final Completer? completer;
  final int id;

  List<Object?> get props => [completer, id];
}
