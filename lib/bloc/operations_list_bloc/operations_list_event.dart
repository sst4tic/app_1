part of 'operations_list_bloc.dart';

abstract class OperationsListEvent {}

class LoadOperations extends OperationsListEvent {
  LoadOperations({
    this.completer,
    this.query,
    this.filters
  });

  final Completer? completer;
  final String? query;
  final String? filters;

  List<Object?> get props => [completer];
}

class LoadMore extends OperationsListEvent {
  LoadMore({
    this.completer,
    this.hasMore,
    this.query,
    this.filters
  });

  final Completer? completer;
  final bool? hasMore;
  final String? query;
  final String? filters;

  List<Object?> get props => [];
}

