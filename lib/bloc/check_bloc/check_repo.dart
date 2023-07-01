
import 'dart:convert';
import 'package:yiwucloud/bloc/check_bloc/abstract_check.dart';
import 'package:yiwucloud/models%20/workpace_model.dart';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';

class CheckRepo implements AbstractCheck {
  @override
  Future<WorkpaceModel> loadCheck() async {
    var url = '${Constants.API_URL_DOMAIN}action=workpace';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = body['data'];
    return WorkpaceModel.fromJson(data);
  }

  @override
  Future workpacePostpone({required String lat, required String lon, required String type}) async {
    var url = '${Constants.API_URL_DOMAIN}action=workpace_post&lat=$lat&lon=$lon&type=$type';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
}