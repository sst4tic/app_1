part of 'operations_list_bloc.dart';

abstract class OperationsListState {
  get page => 1;
  bool get hasMore => true;
}

class OperationsListInitial extends OperationsListState {}

class OperationsListLoading extends OperationsListState {
  OperationsListLoading({
    this.completer,
  });

  final Completer? completer;
}

class OperationsListLoaded extends OperationsListState {
  OperationsListLoaded({
    required this.operationsList,
    required this.page,
    required this.hasMore,
  });

  final OperationModel operationsList;
  @override
  final int page;
  @override
  final bool hasMore;
}

class OperationsListLoadingFailure extends OperationsListState {
  OperationsListLoadingFailure({
    this.exception,
  });

  final Object? exception;
}


