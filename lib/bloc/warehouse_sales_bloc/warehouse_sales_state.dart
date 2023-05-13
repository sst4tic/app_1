part of 'warehouse_sales_bloc.dart';

abstract class WarehouseSalesState {
  get page => 1;
  bool get hasMore => true;
}

class WarehouseSalesInitial extends WarehouseSalesState {}

class WarehouseSalesLoading extends WarehouseSalesState {
  WarehouseSalesLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class WarehouseSalesLoaded extends WarehouseSalesState {
  WarehouseSalesLoaded({
    required this.warehouseSales,
    required this.page,
    required this.hasMore,
  });

  final WarehouseSalesModel warehouseSales;
  @override
  final int page;
  @override
  final bool hasMore;

  List<Object?> get props => [warehouseSales, page, hasMore];
}

class WarehouseSalesLoadingMore extends WarehouseSalesState {
  WarehouseSalesLoadingMore(
    this.warehouseSales,
    this.completer,
  );

  final Completer? completer;
  final List<WarehouseSalesModel> warehouseSales;

  List<Object?> get props => [completer, warehouseSales];
}

class WarehouseSalesLoadingFailure extends WarehouseSalesState {
  WarehouseSalesLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}