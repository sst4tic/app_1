part of 'product_detail_bloc.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductDetailsWithWarehouses product;

  ProductDetailLoaded({required this.product});
  List<Object?> get props => [product];
}

class ProductDetailLoadingFailure extends ProductDetailState {
  final Object? exception;

  ProductDetailLoadingFailure({this.exception});
}