import 'dart:convert';
import 'package:yiwucloud/bloc/scan_result_bloc/abstract_scan_result.dart';
import 'package:yiwucloud/util/constants.dart';
import 'package:http/http.dart' as http;

class ScanResultRepo implements AbstractScanResult {
  @override
  Future<ResultModel> getScanResult(code) async {
    var url = '${Constants.API_URL_DOMAIN}action=global_scan&code=$code';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final result = ResultModel.fromJson(body);
    return result;
  }
}

////////////////////////////////////////
class ResultModel {
  ResultModel({
    required this.success,
    required this.message,
    required this.data,
  });

  late final bool success;
  late final String message;
  late final Data data;

  ResultModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = success ? Data.fromJson(json['data']) : Data(type: '');
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({required this.type, this.invoiceId, this.productId, this.id});

  late final String type;
  late final String? invoiceId;
  late final int? id;
  late final int? productId;

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    invoiceId = json['invoice_id'];
    id = json['id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['invoice_id'] = invoiceId;
    data['id'] = id;
    data['product_id'] = productId;
    return data;
  }
}
