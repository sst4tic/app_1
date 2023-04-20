import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';
import 'abstract_home_page.dart';

class HomePageRepository implements AbstractHomePage {
  @override
  getHomePage() async {
    var url = '${Constants.API_URL_DOMAIN}action=home_page';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        Constants.header: Constants.bearer,
      },
    );
    final body = jsonDecode(response.body);
    return body;
  }
}
