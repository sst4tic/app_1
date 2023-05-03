part of 'products_bloc.dart';

abstract class ProductsState {
  get page => 1;

  bool get hasMore => true;

}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {
  ProductsLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class ProductsLoaded extends ProductsState {
  ProductsLoaded({
    required this.products, required this.page, required this.hasMore,
  });

  final List<Product> products;
  final int page;
  final bool hasMore;

  List<Object?> get props => [products, page, hasMore];
}

class ProductsLoadingFailure extends ProductsState {
  ProductsLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}

class ProductsLoadingMore extends ProductsState {
  ProductsLoadingMore(
    this.products,
    this.completer,
  );

  final Completer? completer;
  final List<Product> products;

  List<Object?> get props => [completer, products];
}

class ProductsLoadingMoreFailure extends ProductsState {
  ProductsLoadingMoreFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}
