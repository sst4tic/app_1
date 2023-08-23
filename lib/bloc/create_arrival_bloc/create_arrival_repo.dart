import 'dart:convert';
import 'package:yiwucloud/bloc/create_arrival_bloc/abstract_create_arrival.dart';
import '../../util/arrival_existence_model.dart';
import '../../util/constants.dart';
import 'package:http/http.dart' as http;

class CreateArrivalRepo implements AbstractCreateArrival {
  @override
  Future<ArrivalExistenceModel> checkArrivalExistence({required String sku}) async {
    var url = '${Constants.API_URL_DOMAIN}action=search_arrival_sku&sku=$sku';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    final body = jsonDecode(response.body);
    final data = body['data'];
    final arrival = ArrivalExistenceModel.fromJson(data);
    return arrival;
  }
  @override
  Future addExistArrival({required sku, required warehouseId, required quantity, required id}) async {
    var url = '${Constants.API_URL_DOMAIN}action=arrival_addition_exists&sku=$sku&id=$id&quantity=$quantity&warehouse_id=$warehouseId';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    final body = jsonDecode(response.body);
    return body;
  }
  @override
  Future addNonExistArrival({required sku, required warehouseId, required quantity, required name, required price}) async {
    var url = '${Constants.API_URL_DOMAIN}action=arrival_addition_new&sku=$sku&name_ru=$name&price_retail=$price&quantity=$quantity&warehouse_id=$warehouseId';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    final body = jsonDecode(response.body);
    return body;
  }
}