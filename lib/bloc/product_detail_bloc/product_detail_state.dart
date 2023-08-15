part of 'product_detail_bloc.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductDetailsWithWarehouses product;
  final List<DropdownMenuItem> warehouses;
  final String value;

  ProductDetailLoaded({required this.product, required this.warehouses, required this.value});
  List<Object?> get props => [product];
}

class ProductDetailLoadingFailure extends ProductDetailState {
  final Object? exception;

  ProductDetailLoadingFailure({this.exception});
}