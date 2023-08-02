import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import 'package:yiwucloud/screens%20/global_scan_screen.dart';
import 'package:yiwucloud/util/comment_model.dart';
import 'package:yiwucloud/util/product_details.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models /product_filter_model.dart';
import 'constants.dart';
import 'filter_list_model.dart';
import 'notification_model.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class Func {
  showSnackbar(context, String text, bool success) {
    success
        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text(
              text,
              style: TextStyle(
                  color: success ? Colors.green : Colors.red, fontSize: 17),
            ),
            backgroundColor: Colors.black87,
          ))
        : showDialog<void>(
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

  // for prod detail
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
    return ProductDetailsWithWarehouses(data: data, warehouses: wareHouse);
  }

  // for change location
  Future changeLocation(
      {required int prodId,
      required int warehouseId,
      required String location}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=product_locations_post&product_id=$prodId&warehouse_id=$warehouseId&locations=$location';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
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
    return body['data']
        .map<CommentModel>((json) => CommentModel.fromJson(json))
        .toList();
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
    final notification = body['data']
        .map<NotificationClass>((json) => NotificationClass.fromJson(json))
        .toList();
    return notification;
  }

  // func for getting products filters
  Future<List<ProductFilterModel>> getProductsFilters() async {
    var url = '${Constants.API_URL_DOMAIN}action=filters_list_products';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = body['data']
        .map<ProductFilterModel>((json) => ProductFilterModel.fromJson(json))
        .toList();
    return data;
  }

  // func for getting moving filters
  Future<List<ProductFilterModel>> getMovingFilters() async {
    var url = '${Constants.API_URL_DOMAIN}action=filters_list_moving';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = body['data']
        .map<ProductFilterModel>((json) => ProductFilterModel.fromJson(json))
        .toList();
    return data;
  }

  // func for getting filters
  Future<FilterModel> getFilters() async {
    var url = '${Constants.API_URL_DOMAIN}action=filters_list';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = FilterModel.fromJson(body['data']);
    return data;
  }

  // for zebra scanner
  void initGlobalScanner() {
    if (Platform.isAndroid && Constants.useragent == 'TC26') {
      onScanResultListener = fdw.onScanResult.listen((result) {
        onScanResultListener.pause;
        if (!navKey.currentState!.canPop()) {
          navKey.currentState!
              .push(
                MaterialPageRoute(
                    builder: (context) => GlobalScanScreen(
                          scanData: result.data,
                        )),
              )
              .then((value) => onScanResultListener.resume());
        }
      });
    }
  }

  // for disable and enable scanner
  void disableScanner(currentIndex) {
    if (Platform.isAndroid && Constants.useragent == 'TC26') {
      if (currentIndex != 1) {
        fdw.enableScanner(false);
      } else {
        fdw.enableScanner(true);
      }
    }
  }

  // for clear scanner
  void clearScanner() {
    if (Platform.isAndroid && Constants.useragent == 'TC26') {
      onScanResultListener = fdw.onScanResult.listen((result) {});
    }
  }
}

Future<File> getImageFromGallery() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  return File(pickedFile!.path);
}

Future<File> takeImageFromCamera() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  return File(pickedFile!.path);
}

String imageToBase64(File imageFile) {
  List<int> imageBytes = imageFile.readAsBytesSync();
  return base64Encode(imageBytes);
}

Future<void> uploadImg(File imageFile, BuildContext context) async {
  context.loaderOverlay.show();
  var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();
  var uploadURL = '${Constants.BASE_URL_DOMAIN}api/user-avatar-post';

  var uri = Uri.parse(uploadURL);
  var request = http.MultipartRequest("POST", uri);
  request.headers['Authorization'] = Constants.bearer;
  var multipartFile = http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  request.files.add(multipartFile);
  var response = await request.send();
  try {
    await response.stream.transform(utf8.decoder).join();
  } catch (e) {

  }
  // ignore: use_build_context_synchronously
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: response.statusCode == 200 ? 'Успешно' : 'Ошибка',
          content: Text(response.statusCode == 200
              ? 'Фото успешно загружено!'
              : 'Произошла ошибка!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ок'),
            )
          ],
        );
      });
  // ignore: use_build_context_synchronously
  context.loaderOverlay.hide();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}