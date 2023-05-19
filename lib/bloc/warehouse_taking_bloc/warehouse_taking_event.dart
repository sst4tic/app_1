part of 'warehouse_taking_bloc.dart';

abstract class WarehouseTakingEvent {}

class LoadWarehouseTaking extends WarehouseTakingEvent {
  LoadWarehouseTaking({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}