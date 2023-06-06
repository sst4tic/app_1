import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../util/constants.dart';
import '../../util/warehouse_sale.dart';

class SalesRepo {
Future<WarehouseSalesModel> getSales({required int page, String? query}) async {
  var url = '${Constants.API_URL_DOMAIN}action=sales_list&page=$page&smart=$query';
  print(url);
  final response = await http.get(
      Uri.parse(url),
      headers: Constants.headers()
  );
  final body = jsonDecode(response.body);
  print(body);
  return WarehouseSalesModel.fromJson(body['data']);
  }
}