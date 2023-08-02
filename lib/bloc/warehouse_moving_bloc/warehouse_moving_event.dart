part of 'warehouse_moving_bloc.dart';

abstract class WarehouseMovingEvent {}

class LoadMoving extends WarehouseMovingEvent {
  LoadMoving({
    this.completer,
    this.query,
    this.filters
  });

  final Completer? completer;
  final String? query;
  final String? filters;

  List<Object?> get props => [completer];
}

class LoadMore extends WarehouseMovingEvent {
  LoadMore({
    this.completer,
    this.hasMore,
    this.query,
    this.filters
  });

  final Completer? completer;
  final bool? hasMore;
  final String? query;
  final String? filters;

  List<Object?> get props => [];
}