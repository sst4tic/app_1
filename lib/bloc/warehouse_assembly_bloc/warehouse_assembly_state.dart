part of 'warehouse_assembly_bloc.dart';

abstract class WarehouseAssemblyState {
  get page => 1;
  bool get hasMore => true;
}

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
    required this.warehouseAssemblyPostponed,
    required this.totalCount,
    required this.totalCountPostponed,
    required this.page,
    required this.hasMore,
  });

  final List<Sales> warehouseAssembly;
  final List<Sales> warehouseAssemblyPostponed;
  final int totalCount;
  final int totalCountPostponed;
  @override
  final int page;
  @override
  final bool hasMore;

  List<Object?> get props => [warehouseAssembly];
}

class WarehouseAssemblyLoadingFailure extends WarehouseAssemblyState {
  WarehouseAssemblyLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}