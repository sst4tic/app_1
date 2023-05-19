part of 'warehouse_taking_bloc.dart';

 abstract class WarehouseTakingState {}

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
  });

  final List<Sales> warehouseTaking;
  final List<Sales> warehouseCompleted;


  List<Object?> get props => [warehouseTaking, warehouseCompleted];
}

class WarehouseTakingLoadingFailure extends WarehouseTakingState {
  WarehouseTakingLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}