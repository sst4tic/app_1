import '../../util/product.dart';

abstract class AbstractProducts {
  Future<List<Product>> getProducts({required int page});
}