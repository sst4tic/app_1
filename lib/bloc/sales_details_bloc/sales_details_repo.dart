import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yiwucloud/bloc/sales_details_bloc/abstract_sales_details.dart';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';
import '../../util/sales_details_model.dart';

class SalesDetailsRepo implements AbstractSalesDetails {
  @override
  Future<SalesDetailsModel> loadSalesDetails({required int id}) async {
    var url = '${Constants.API_URL_DOMAIN}action=sale_details&id=$id';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = body['data'];
    final salesDetails = SalesDetailsModel.fromJson(data);
    return salesDetails;
  }

  @override
  Future movingRedirection({required int id, required String act, double? lat, double? lon}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=sale_moving_redirection&id=$id&act=$act&lon=$lon&lat=$lat';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }

  @override
  Future changeBoxQty({required int id, required boxQty}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=warehouse_products_invoices_boxes_change&invoice_id=$id&qty=$boxQty';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
  @override
  Future<List<DropdownMenuItem>> getPostponeReasons() async {
    var url = '${Constants.API_URL_DOMAIN}action=invoice_scans_reasons';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body['data'].map<DropdownMenuItem>((e) => DropdownMenuItem(
      value: e['id'],
      child: Text(e['name'], maxLines: 1,),
    )).toList();
  }
  @override
  Future sendPostpone({required int reasonId, required int id}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=postponed_scans&invoice_id=$id&reason_id=$reasonId';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
  @override
  Future defineCourier({required int invoiceId, required int courierId}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=request_define_courier&invoice_id=$invoiceId&courier_id=$courierId';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
}
