part of 'warehouse_moving_bloc.dart';

abstract class WarehouseMovingEvent {}

class LoadMoving extends WarehouseMovingEvent {
  LoadMoving({
    this.completer,
    this.query,
  });

  final Completer? completer;
  final String? query;

  List<Object?> get props => [completer];
}

class LoadMore extends WarehouseMovingEvent {
  LoadMore({
    this.completer,
    this.hasMore,
  });

  final Completer? completer;
  final bool? hasMore;

  List<Object?> get props => [];
}