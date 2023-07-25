part of 'warehouse_taking_bloc.dart';

abstract class WarehouseTakingState {
  get page => 1;
  get pageCompleted => 1;
  bool get hasMore => true;
  bool get hasMoreCompleted => true;
}

class WarehouseTakingInitial extends WarehouseTakingState {}

class WarehouseTakingLoading extends WarehouseTakingState {
  WarehouseTakingLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class WarehouseTakingLoaded extends WarehouseTakingState {
  WarehouseTakingLoaded({
    required this.warehouseTaking,
    required this.warehouseCompleted,
    required this.totalCount,
    required this.totalCountCompleted,
    required this.page,
    required this.pageCompleted,
    required this.hasMore,
    required this.hasMoreCompleted,
    required this.movingList,
  });

  final List<Sales> warehouseTaking;
  final List<Sales> warehouseCompleted;
  final List<MovingModel> movingList;
  final int totalCount;
  final int totalCountCompleted;
  @override
  final int page;
  @override
  final int pageCompleted;
  @override
  final bool hasMore;
  @override
  final bool hasMoreCompleted;

  List<Object?> get props => [warehouseTaking, warehouseCompleted];
}

class WarehouseTakingLoadingFailure extends WarehouseTakingState {
  WarehouseTakingLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}
