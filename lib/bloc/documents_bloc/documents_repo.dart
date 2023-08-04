
import 'dart:convert';

import 'package:yiwucloud/models%20/product_filter_model.dart';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';
import 'abstract_documents.dart';

class DocumentsRepo implements AbstractDocuments {
  @override
  Future<List<DocumentModel>> getDocuments({required String type, required int page}) async {
    var url = '${Constants.API_URL_DOMAIN}action=user_documents_list&type_id=$type&page=$page';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    final body = jsonDecode(response.body);

    final List<dynamic> data = body['data'];
    final documents = data.map((item) => DocumentModel.fromJson(item)).toList();
    return documents;
  }

  @override
  Future<ProductFilterModel> getType() async {
    var url = '${Constants.API_URL_DOMAIN}action=user_documents_types';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    final body = jsonDecode(response.body);
    final data = ProductFilterModel.fromJson(body['data']);
    return data;
  }
}