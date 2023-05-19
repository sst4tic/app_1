part of 'warehouse_assembly_bloc.dart';

abstract class WarehouseAssemblyState {}

class WarehouseAssemblyInitial extends WarehouseAssemblyState {}

class WarehouseAssemblyLoading extends WarehouseAssemblyState {
  WarehouseAssemblyLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class WarehouseAssemblyLoaded extends WarehouseAssemblyState {
  WarehouseAssemblyLoaded({
    required this.warehouseAssembly,
  });

  final List<Sales> warehouseAssembly;

  List<Object?> get props => [warehouseAssembly];
}

class WarehouseAssemblyLoadingFailure extends WarehouseAssemblyState {
  WarehouseAssemblyLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}