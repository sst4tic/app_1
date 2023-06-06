
import 'dart:convert';

import 'package:yiwucloud/bloc/products_bloc/abstact_products.dart';
import 'package:yiwucloud/util/constants.dart';
import '../../util/product.dart';
import 'package:http/http.dart' as http;
class ProductsRepo implements AbstractProducts {
  @override
  Future<List<Product>> getProducts({required int page, String? query}) async {
    var url = '${Constants.API_URL_DOMAIN}action=products_list&page=$page&smart=$query';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    print(url);
    final body = jsonDecode(response.body);
    final List<dynamic> data = body['data'];
    final products = data.map((item) => Product.fromJson(item)).toList();
    return products;
  }
}