part of 'operation_creating_bloc.dart';

abstract class OperationCreatingState {}

class OperationCreatingInitial extends OperationCreatingState {}

class OperationCreateState extends OperationCreatingState {
  OperationCreateState({
    required this.billsList,
    required this.articlesList,
    required this.operationTypes,
    required this.invoiceId,
    required this.totalSum,
    this.comments,
  });
   List<ChildData> billsList;
   List<ArticlesListModel> articlesList;
   List<ChildDataProduct> operationTypes;
  final String invoiceId;
  final String totalSum;
  final String? comments;


}

class MovingCreateState extends OperationCreatingState {
  MovingCreateState({
    required this.billsList,
    required this.totalSum,
    this.comments,
  });
  final List<ChildData> billsList;
  final String totalSum;
  final String? comments;
}

class OperationLoadingFailure extends OperationCreatingState {
  OperationLoadingFailure(this.e);

  final Object? e;
}
