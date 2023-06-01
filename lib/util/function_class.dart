import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import 'package:yiwucloud/util/comment_model.dart';
import 'package:yiwucloud/util/product_details.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'notification_model.dart';

class Func {
  showSnackbar(context, String text, bool success) {
    success ?
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Text(
        text,
        style:
        TextStyle(color: success ? Colors.green : Colors.red, fontSize: 17),
      ),
      backgroundColor: Colors.black87,
    )) :
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomAlertDialog(
          title: 'Произошла ошибка!',
          content: Text(text),
          actions: [
            CustomDialogAction(
              text: 'Ок',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  String strLimit(String str, int limit) {
    if (str.length <= limit) {
      return str;
    }
    return '${str.substring(0, limit)}...';
  }
  Future<ProductDetailsWithWarehouses> loadProductDetail(id) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=product_details&product_id=$id';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = ProductDetails.fromJson(body['data']);
    final List<Warehouses> wareHouse = body['warehouses']
        .map<Warehouses>((json) => Warehouses.fromJson(json))
        .toList();
    return ProductDetailsWithWarehouses(
        data: data, warehouses: wareHouse);
  }

 Future loadWarehousesList() async {
    var url = '${Constants.API_URL_DOMAIN}action=warehouses_list';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }

  Future<List<CommentModel>> getComments({required int id}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=comments_list_of_invoice&id=$id';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body['data'].map<CommentModel>((json) => CommentModel.fromJson(json)).toList();
  }
  Future postComment({required int id, required String message}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=comments_post_of_invoice&id=$id&message=$message';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body['data'];
  }

  // func for load notification list
  Future<List<NotificationClass>> getNotifications() async {
    var url = '${Constants.API_URL_DOMAIN}action=notifications_list';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final notification = body['data'].map<NotificationClass>((json) => NotificationClass.fromJson(json)).toList();
    return notification;
  }

}