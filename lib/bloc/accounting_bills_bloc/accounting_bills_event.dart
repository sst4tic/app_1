part of 'accounting_bills_bloc.dart';

abstract class AccountingBillsEvent {}

class LoadAccountingBills extends AccountingBillsEvent {
  LoadAccountingBills();
}

class LoadMore extends AccountingBillsEvent {
  int? page;

  LoadMore({this.page});
}

class CreateAccountingBills extends AccountingBillsEvent {
  CreateAccountingBills({
    this.completer,
  });

  final Completer? completer;
}

class BillsEditEvent extends AccountingBillsEvent {
  BillsEditEvent({
    this.completer,
    required this.id,
    required this.name,
  });

  final Completer? completer;
  final String name;
  final int id;
}