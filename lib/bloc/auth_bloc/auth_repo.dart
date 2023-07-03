import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yiwucloud/bloc/auth_bloc/abstract_auth.dart';
import '../../util/constants.dart';
import 'package:http/http.dart' as http;

class AuthRepo implements AbstractAuth {
  @override
  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('login') ?? "";
  }

  @override
  Future login(String email, String password, context) async {
    final Dio dio = Dio();
    try {
      Response response = await dio
          .get('${Constants.API_URL_DOMAIN}action=auth&', queryParameters: {
        "email": email,
        "password": password,
      });
      if (response.data['api_token'] != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('login', response.data['api_token']);
        Constants.USER_TOKEN = response.data['api_token'];
        Constants.bearer = 'Bearer ${response.data['api_token']}';
      }
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  @override
  Future<void> getFirebaseToken(val) async {
    if (val) {
      FirebaseMessaging.instance.deleteToken();
    } else {
      FirebaseMessaging.instance.getToken().then((value) async {
        var url =
            '${Constants.API_URL_DOMAIN}action=fcm_device_token_post&fcm_device_token=$value';
        var resp = await http.get(Uri.parse(url), headers: Constants.headers());
        return resp;
      });
    }
  }

  @override
  Future deleteAccount() async {
    var url = '${Constants.API_URL_DOMAIN}action=user_delete';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return body;
  }
}
