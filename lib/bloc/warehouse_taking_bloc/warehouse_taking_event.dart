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

class LoadMore extends WarehouseTakingEvent {
  LoadMore({
    this.completer,
    this.hasMore,
  });

  final Completer? completer;
  final bool? hasMore;

  List<Object?> get props => [completer];
}