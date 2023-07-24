import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';
import 'abstract_moving_scanner.dart';

class MovingScannerRepo implements AbstractMovingScanner {
  @override
  Future loadData({required id}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=moving_products_list_qty&id=$id';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }

  @override
  Future movingScan({required id, required String barcode}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=moving_scan&moving_id=$id&barcode=$barcode';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }

  @override
  Future movingScanQty(
      {required id, required String barcode, required dynamic qty}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=moving_scan&moving_id=$id&barcode=$barcode&qty=$qty';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
}
