part of 'warehouse_taking_bloc.dart';

abstract class WarehouseTakingEvent {}

class LoadWarehouseTaking extends WarehouseTakingEvent {
  LoadWarehouseTaking({
    this.completer,
    this.query,
    this.filters,
  });

  final Completer? completer;
  final String? query;
  final String? filters;

  List<Object?> get props => [completer];
}