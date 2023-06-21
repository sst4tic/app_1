part of 'products_bloc.dart';

abstract class ProductsEvent {}

class LoadProducts extends ProductsEvent {
  LoadProducts({
    this.completer,
    this.query,
    this.filters
  });

  final Completer? completer;
  final String? query;
  final String? filters;

  List<Object?> get props => [completer, query, filters];
}

class LoadMore extends ProductsEvent {
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

  List<Object?> get props => [completer, hasMore, query, filters];
}