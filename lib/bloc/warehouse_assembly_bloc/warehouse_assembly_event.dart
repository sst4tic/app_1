part of 'warehouse_assembly_bloc.dart';

abstract class WarehouseAssemblyEvent {}

class LoadWarehouseAssembly extends WarehouseAssemblyEvent {
  LoadWarehouseAssembly({
    this.completer,
    this.query,
    this.filters
  });

  final Completer? completer;
  final String? query;
  final String? filters;

  List<Object?> get props => [completer, query, filters];
}

class LoadMore extends WarehouseAssemblyEvent {
  LoadMore({
    this.completer,
    this.hasMore,
  });

  final Completer? completer;
  final bool? hasMore;

  List<Object?> get props => [completer];
}