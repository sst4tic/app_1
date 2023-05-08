part of 'warehouse_arrival_bloc.dart';

abstract class WarehouseArrivalEvent {}

class LoadArrival extends WarehouseArrivalEvent {
  LoadArrival({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class LoadMore extends WarehouseArrivalEvent {
  LoadMore({
    this.completer,
    this.hasMore,
  });

  final Completer? completer;
  final bool? hasMore;

  List<Object?> get props => [];
}