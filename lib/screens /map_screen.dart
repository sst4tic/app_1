import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key, required this.lat, required this.lon}) : super(key: key);
  final String lat;
  final String lon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта с точкой'),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://2gis.kz/search/$lat,$lon',
      )
    );
  }
}
