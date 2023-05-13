part of 'products_bloc.dart';

abstract class ProductsEvent {}

class LoadProducts extends ProductsEvent {
  LoadProducts({
    this.completer,
    this.media,
    this.orderby,
    this.availability,
  });

  final Completer? completer;
  final String? media;
  final String? orderby;
  final String? availability;

  List<Object?> get props => [completer, media, orderby, availability];
}

class LoadMore extends ProductsEvent {
  LoadMore({
    this.completer,
    this.media,
    this.orderby,
    this.availability,
    this.hasMore,
  });

  final Completer? completer;
  final String? media;
  final String? orderby;
  final String? availability;
  final bool? hasMore;

  List<Object?> get props => [completer, media, orderby, availability, hasMore];
}