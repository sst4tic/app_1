part of 'warehouse_categories_bloc.dart';

abstract class WarehouseCategoriesEvent {}

class LoadWarehouseCategories extends WarehouseCategoriesEvent {
  LoadWarehouseCategories({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}