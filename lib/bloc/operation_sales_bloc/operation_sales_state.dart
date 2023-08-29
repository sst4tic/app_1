part of 'operation_sales_bloc.dart';

abstract class OperationSalesState {}

class OperationSalesInitial extends OperationSalesState {}

class OperationSalesLoading extends OperationSalesState {}

class OperationSalesLoaded extends OperationSalesState {
  OperationSalesLoaded({required this.operationSales});

  final OperationSalesModel operationSales;
}

class OperationSalesError extends OperationSalesState {
  OperationSalesError({this.e});

  final Object? e;
}
