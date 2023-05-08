part of 'warehouse_arrival_bloc.dart';

abstract class WarehouseArrivalState {
  get page => 1;
  bool get hasMore => true;
}

class WarehouseArrivalInitial extends WarehouseArrivalState {}

class WarehouseArrivalLoading extends WarehouseArrivalState {
  WarehouseArrivalLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}
class WarehouseArrivalLoaded extends WarehouseArrivalState {
  WarehouseArrivalLoaded({
    required this.warehouseArrival,
    required this.page,
    required this.hasMore,
  });

  final List<ArrivalModel> warehouseArrival;
  @override
  final int page;
  @override
  final bool hasMore;

  List<Object?> get props => [warehouseArrival, page, hasMore];
}

class WarehouseArrivalLoadingMore extends WarehouseArrivalState {
  WarehouseArrivalLoadingMore(
    this.warehouseArrival,
    this.completer,
  );

  final Completer? completer;
  final List<ArrivalModel> warehouseArrival;

  List<Object?> get props => [completer, warehouseArrival];
}

class WarehouseArrivalLoadingFailure extends WarehouseArrivalState {
  WarehouseArrivalLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}
