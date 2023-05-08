part of 'warehouse_categories_bloc.dart';

abstract class WarehouseCategoriesState {}

class WarehouseCategoriesInitial extends WarehouseCategoriesState {}

class WarehouseCategoriesLoading extends WarehouseCategoriesState{
  WarehouseCategoriesLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class WarehouseCategoriesLoaded extends WarehouseCategoriesState{
  WarehouseCategoriesLoaded({
    required this.categories,
  });

  final List<WarehouseCategory> categories;

  List<Object?> get props => [categories];
}

class WarehouseCategoriesError extends WarehouseCategoriesState{
  WarehouseCategoriesError({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}