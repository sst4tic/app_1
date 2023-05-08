part of 'warehouse_sales_bloc.dart';

abstract class WarehouseSalesEvent {}

class LoadWarehouseSales extends WarehouseSalesEvent {
  LoadWarehouseSales({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
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
