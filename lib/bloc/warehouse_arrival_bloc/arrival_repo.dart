import 'dart:convert';
import 'package:yiwucloud/bloc/warehouse_arrival_bloc/abstract_arrival.dart';
import 'package:http/http.dart' as http;
import '../../util/arrival_model.dart';
import '../../util/constants.dart';

class ArrivalRepo implements AbstractArrival {
  @override
  Future<List<ArrivalModel>> getArrival({required int page}) async {
    var url = '${Constants.API_URL_DOMAIN}action=arrival_list&page=$page';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    final body = jsonDecode(response.body);
    final List<dynamic> data = body['data'];
    final sales = data.map((item) => ArrivalModel.fromJson(item)).toList();
    return sales;
  }
}