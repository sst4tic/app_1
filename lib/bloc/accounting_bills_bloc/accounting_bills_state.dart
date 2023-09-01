part of 'accounting_bills_bloc.dart';

abstract class AccountingBillsState {
  get page => 1;
  bool get hasMore => true;
}

class AccountingBillsInitial extends AccountingBillsState {}

class AccountingBillsLoading extends AccountingBillsState {}

class AccountingBillsLoaded extends AccountingBillsState {
  final BillsModel bills;
  @override
  final int page;
  @override
  final bool hasMore;

  AccountingBillsLoaded({required this.bills, required this.page, required this.hasMore});
}

class AccountingBillsError extends AccountingBillsState {
  final Object e;

  AccountingBillsError({required this.e});
}