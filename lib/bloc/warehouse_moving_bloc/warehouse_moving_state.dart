part of 'warehouse_moving_bloc.dart';

abstract class WarehouseMovingState {
  get page => 1;
  bool get hasMore => true;
}

class WarehouseMovingInitial extends WarehouseMovingState {}

class WarehouseMovingLoading extends WarehouseMovingState {
  WarehouseMovingLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class WarehouseMovingLoaded extends WarehouseMovingState {
  WarehouseMovingLoaded({
    required this.warehouseMoving,
    required this.page,
    required this.hasMore,
  });

  final List<MovingModel> warehouseMoving;
  @override
  final int page;
  @override
  final bool hasMore;

  List<Object?> get props => [warehouseMoving, page, hasMore];
}

class WarehouseMovingLoadingMore extends WarehouseMovingState {
  WarehouseMovingLoadingMore(
    this.warehouseMoving,
    this.completer,
  );

  final Completer? completer;
  final List<MovingModel> warehouseMoving;

  List<Object?> get props => [completer, warehouseMoving];
}

class WarehouseMovingLoadingFailure extends WarehouseMovingState {
  WarehouseMovingLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}



