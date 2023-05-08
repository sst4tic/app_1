import 'dart:convert';
import 'package:yiwucloud/bloc/warehouse_moving_bloc/abstract_moving.dart';
import '../../util/constants.dart';
import '../../util/moving_model.dart';
import 'package:http/http.dart' as http;

class MovingRepo implements AbstractMoving {
  @override
  Future<List<MovingModel>> getMoving({required int page}) async {
    var url = '${Constants.API_URL_DOMAIN}action=moving_list&page=$page';
    final response = await http.get(
        Uri.parse(url),
        headers: Constants.headers()
    );
    final body = jsonDecode(response.body);
    final List<dynamic> data = body['data'];
    final moving = data.map((item) => MovingModel.fromJson(item)).toList();
    return moving;
  }
}