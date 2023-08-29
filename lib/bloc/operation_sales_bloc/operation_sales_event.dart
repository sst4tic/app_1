part of 'operation_sales_bloc.dart';

abstract class OperationSalesEvent {}

class LoadOperationSales extends OperationSalesEvent {
  LoadOperationSales({required this.id});

  final int id;
}

class CreateOperationSales extends OperationSalesEvent {
  CreateOperationSales({required this.id});

  final int id;
}

class OperationSalesDelete extends OperationSalesEvent {
  OperationSalesDelete({required this.id, required this.invoiceId});

  final int id;
  final int invoiceId;
}