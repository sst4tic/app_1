part of 'products_bloc.dart';

abstract class ProductsEvent {}

class LoadProducts extends ProductsEvent {
  LoadProducts({
    this.completer,
    this.media,
    this.orderby,
    this.availability,
    this.query
  });

  final Completer? completer;
  final String? media;
  final String? orderby;
  final String? availability;
  final String? query;

  List<Object?> get props => [completer, media, orderby, availability, query];
}

class LoadMore extends ProductsEvent {
  LoadMore({
    this.completer,
    this.media,
    this.orderby,
    this.availability,
    this.hasMore,
    this.query
  });

  final Completer? completer;
  final String? media;
  final String? orderby;
  final String? availability;
  final bool? hasMore;
  final String? query;

  List<Object?> get props => [completer, media, orderby, availability, hasMore, query];
}