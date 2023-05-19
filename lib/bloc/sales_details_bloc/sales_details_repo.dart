
import 'dart:convert';

import 'package:yiwucloud/bloc/sales_details_bloc/abstract_sales_details.dart';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';
import '../../util/sales_details_model.dart';

class SalesDetailsRepo implements AbstractSalesDetails {
  @override
  Future<SalesDetailsModel> loadSalesDetails({required int id}) async {
    var url = '${Constants.API_URL_DOMAIN}action=sale_details&id=$id';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    final body = jsonDecode(response.body);
    final data = body['data'];
    final salesDetails = SalesDetailsModel.fromJson(data);
    return salesDetails;
  }
  @override
  Future movingRedirection({required int id, required String act}) async {
    var url = '${Constants
        .API_URL_DOMAIN}action=sale_moving_redirection&id=$id&act=$act';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    final body = jsonDecode(response.body);
    return body;
  }
  @override
  Future changeBoxQty({required int id, required boxQty}) async {
    var url = '${Constants
        .API_URL_DOMAIN}action=warehouse_products_invoices_boxes_change&invoice_id=$id&qty=$boxQty';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    final body = jsonDecode(response.body);
    return body;
  }
}