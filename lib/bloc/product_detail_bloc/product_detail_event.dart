part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent {}

class LoadProductDetail extends ProductDetailEvent {
  final String id;
  final Completer? completer;

  LoadProductDetail({required this.id, this.completer});
}
