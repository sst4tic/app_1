part of 'warehouse_assembly_bloc.dart';

abstract class WarehouseAssemblyEvent {}

class LoadWarehouseAssembly extends WarehouseAssemblyEvent {
  LoadWarehouseAssembly({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}
