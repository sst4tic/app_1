import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yiwucloud/bloc/moving_details_bloc/abstract_moving_details.dart';
import '../../models /moving_details.dart';
import '../../util/constants.dart';

class MovingDetailsRepo implements AbstractMovingDetails {
  @override
  Future<MovingDetailsModel> loadMovingDetails({required int id}) async {
    var url = '${Constants.API_URL_DOMAIN}action=moving_details&id=$id';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);

    final data = body['data'];
    final movingDetails = MovingDetailsModel.fromJson(data);
    return movingDetails;
  }

  @override
  Future movingRedirection({required int id, required String act}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=moving_redirection&id=$id&act=$act';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }

  @override
  Future defineCourier({required int movingId, required int courierId}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=moving_define_courier&moving_id=$movingId&courier_id=$courierId';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }

  @override
  Future changeBoxQty({required int id, required qty, status}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=moving_boxes_change&id=$id&boxes=$qty&status=$status';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
}
