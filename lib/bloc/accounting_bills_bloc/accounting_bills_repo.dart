import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:yiwucloud/models%20/accounting_bills_model.dart';
import 'package:http/http.dart' as http;
import 'package:yiwucloud/models%20/product_filter_model.dart';
import '../../util/constants.dart';

class AccountingBillsRepo {
  Future<BillsModel> getBills({int? page}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=bills_list&page=$page';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return BillsModel.fromJson(body['data']);
  }

  Future<List<ChildData>> getBillsTypes() async {
    var url =
        '${Constants.API_URL_DOMAIN}action=bills_types';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    Hive.box<List<ChildData>>('bills_types').put('bills_types', List<ChildData>.from(body['data'].map((x) => ChildData.fromJson(x))));
    return List<ChildData>.from(body['data'].map((x) => ChildData.fromJson(x)));
  }

  Future editBill({required int id, required String name, required int type}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=bills_edit&id=$id&name=$name&type=$type';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }

  Future createBill({required String name, required int type}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=bills_add&name=$name&type=$type';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
}