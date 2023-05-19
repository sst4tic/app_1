import 'dart:convert';
import 'package:yiwucloud/bloc/invoice_scanner_bloc/abstract_invoice_scanner.dart';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';

class InvoiceScannerRepo implements AbstractInvoiceScanner {
  @override
  Future loadData({required id}) async {
    var url = '${Constants.API_URL_DOMAIN}action=invoice_products_list_qty_scanned&invoice_id=$id';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
  @override
  Future invoiceScan({required id, required String barcode}) async {
    var url = '${Constants.API_URL_DOMAIN}action=invoice_scan&invoice_id=$id&barcode=$barcode';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
  @override
  Future invoiceScanQty({required id, required String barcode, required dynamic qty}) async {
    var url = '${Constants.API_URL_DOMAIN}action=invoice_scan&invoice_id=$id&barcode=$barcode&qty=$qty';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
}
