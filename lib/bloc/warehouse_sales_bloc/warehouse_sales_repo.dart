import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../util/constants.dart';
import '../../util/warehouse_sale.dart';

class SalesRepo {
Future<List<WarehouseSalesModel>> getSales({required int page}) async {
  var url = '${Constants.API_URL_DOMAIN}action=sales_list&page=$page';
  final response = await http.get(
      Uri.parse(url),
      headers: Constants.headers()
  );
  final body = jsonDecode(response.body);
  final List<dynamic> data = body['data'];
  final sales = data.map((item) => WarehouseSalesModel.fromJson(item)).toList();
  return sales;
  }
}