
import 'dart:convert';

import 'package:yiwucloud/bloc/operation_creating_bloc/abstract_creating_operation.dart';
import 'package:http/http.dart' as http;
import '../../models /articles_list_model.dart';
import '../../models /moving_details.dart';
import '../../models /product_filter_model.dart';
import '../../util/constants.dart';

class OperationCreatingRepo implements AbstractCreatingOperation {
  @override
  Future<List<ChildData>> getBillsList() async {
    var url = '${Constants.API_URL_DOMAIN}action=bills_list_select';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = body['data']
        .map<ChildData>((json) => ChildData.fromJson(json))
        .toList();
    return data;
  }
  @override
  Future<List<ArticlesListModel>> getArticlesList() async {
    var url = '${Constants.API_URL_DOMAIN}action=articles_list';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = body['data']
        .map<ArticlesListModel>((json) => ArticlesListModel.fromJson(json))
        .toList();
    return data;
  }
  @override
  Future<List<ChildDataProduct>> getOperationTypes() async {
    var url = '${Constants.API_URL_DOMAIN}action=operations_types_list';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = body['data']
        .map<ChildDataProduct>((json) => ChildDataProduct.fromJson(json))
        .toList();
    return data;
  }
  @override
  Future submitMoving({required billsIdTo, required billsIdFrom, required total, comments}) async {
    var url = '${Constants.API_URL_DOMAIN}action=operations_moving&bills_id_from=$billsIdFrom&bills_id_to=$billsIdTo&total=$total&comments=$comments';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }

  @override
  Future submitAddition({required billsId, required type, required total, required articleId, required invoiceId, comments}) async {
    var url = '${Constants.API_URL_DOMAIN}action=operations_addition&bills_id=$billsId&type=$type&total=$total&article_id=$articleId&invoice_id=$invoiceId&comments=$comments';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
}