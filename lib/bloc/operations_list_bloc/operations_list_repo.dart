import 'dart:convert';

import 'package:yiwucloud/models%20/operations_model.dart';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';
import 'abstract_operations_list.dart';

class OperationsListRepo implements AbstractOperationsList {
  @override
  Future<OperationModel> getOperations({required int page, String? query, String? filters}) async {
    var url = '${Constants.API_URL_DOMAIN}action=operations_list&page=$page&smart=${query ?? ''}&${filters ?? ''}';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    print(Constants.USER_TOKEN);
    final body = jsonDecode(response.body);
    return OperationModel.fromJson(body['data']);
  }
}