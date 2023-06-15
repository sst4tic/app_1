part of 'warehouse_taking_bloc.dart';

 abstract class WarehouseTakingState {
   get page => 1;
   bool get hasMore => true;
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
    required this.hasMore,
  });

  final List<Sales> warehouseTaking;
  final List<Sales> warehouseCompleted;
  final int totalCount;
  final int totalCountCompleted;
  @override
  final int page;
  @override
  final bool hasMore;

  List<Object?> get props => [warehouseTaking, warehouseCompleted];
}

class WarehouseTakingLoadingFailure extends WarehouseTakingState {
  WarehouseTakingLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}