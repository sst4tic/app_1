import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../util/constants.dart';

class CreateSalePage extends StatefulWidget {
  const CreateSalePage({Key? key}) : super(key: key);

  @override
  State<CreateSalePage> createState() => _CreateSalePageState();
}

class _CreateSalePageState extends State<CreateSalePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Склад: Создание продажи'),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          webViewController.loadUrl('${Constants.BASE_URL_DOMAIN}service/warehouse/products/requests/addition',
              headers: {'Authorization': Constants.bearer}
          );
        },
      )
    );
  }
}
