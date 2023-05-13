import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yiwucloud/util/product_details.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class Func {
  showSnackbar(context, String text, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style:
        TextStyle(color: success ? Colors.green : Colors.red, fontSize: 17),
      ),
      backgroundColor: Colors.black87,
    ));
  }
  String strLimit(String str, int limit) {
    if (str.length <= limit) {
      return str;
    }
    return '${str.substring(0, limit)}...';
  }
  Future<ProductDetailsWithWarehouses> loadProductDetail(id) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=product_details&product_id=$id';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = ProductDetails.fromJson(body['data']);
    final List<Warehouses> wareHouse = body['warehouses']
        .map<Warehouses>((json) => Warehouses.fromJson(json))
        .toList();
    return ProductDetailsWithWarehouses(
        data: data, warehouses: wareHouse);
  }

}