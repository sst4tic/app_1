part of 'products_bloc.dart';

abstract class ProductsEvent {}

class LoadProducts extends ProductsEvent {
  LoadProducts({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class LoadMore extends ProductsEvent {
  LoadMore({
    this.completer,
    this.hasMore,
  });

  final Completer? completer;
  final bool? hasMore;

  List<Object?> get props => [];
}