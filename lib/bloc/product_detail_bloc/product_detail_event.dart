part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent {}

class LoadProductDetail extends ProductDetailEvent {
  final String id;
  final Completer? completer;

  LoadProductDetail({required this.id, this.completer});
}

class ChangeLocation extends ProductDetailEvent {
  final String location;
  final int warehouseId;
  final int productId;
  final BuildContext context;

  final Completer? completer;

  ChangeLocation({required this.location, this.completer, required this.productId, required this.warehouseId, required this.context});
}

class ChangeWarehouseInSale extends ProductDetailEvent {
  final int warehouseId;
  final int productId;
  final BuildContext context;

  final Completer? completer;

  ChangeWarehouseInSale({required this.warehouseId, this.completer, required this.productId, required this.context});
}