part of 'operation_creating_bloc.dart';

abstract class OperationCreatingEvent {}

class CheckOperationType extends OperationCreatingEvent {
  CheckOperationType(this.type);
  final String type;
}

class SubmitOperation extends OperationCreatingEvent {
  SubmitOperation({
    required this.billsId,
    required this.type,
    required this.total,
    required this.articleId,
    this.invoiceId,
    required this.comments,
});
  final String billsId;
  final String type;
  final String total;
  final String articleId;
  final String? invoiceId;
  final String comments;
}

class SubmitMoving extends OperationCreatingEvent {
  SubmitMoving({
    required this.billsIdFrom,
    required this.billsIdTo,
    required this.total,
    required this.comments,
});
  final String billsIdFrom;
  final String billsIdTo;
  final String total;
  final String comments;
}