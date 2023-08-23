part of 'warehouse_arrival_bloc.dart';

abstract class WarehouseArrivalEvent {}

class LoadArrival extends WarehouseArrivalEvent {
  LoadArrival({
    this.completer,
    this.filters
  });

  final Completer? completer;
  final String? filters;

  List<Object?> get props => [completer];
}

class LoadMore extends WarehouseArrivalEvent {
  LoadMore({
    this.completer,
    this.hasMore,
    this.filters
  });

  final Completer? completer;
  final bool? hasMore;
  final String? filters;

  List<Object?> get props => [];
}