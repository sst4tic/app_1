part of 'warehouse_sales_bloc.dart';

abstract class WarehouseSalesEvent {}

class LoadWarehouseSales extends WarehouseSalesEvent {
  LoadWarehouseSales({
    this.completer,
    this.query,
    this.filters
  });

  final Completer? completer;
  final String? query;
  final String? filters;

  List<Object?> get props => [completer, query, filters];
}

class LoadMore extends WarehouseSalesEvent {
  LoadMore({
    this.completer,
    this.hasMore,
  });

  final Completer? completer;
  final bool? hasMore;
  List<Object?> get props => [];
}
