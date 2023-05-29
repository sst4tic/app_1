import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../util/constants.dart';

class CreateSalePage extends StatefulWidget {
  const CreateSalePage({Key? key}) : super(key: key);

  @override
  State<CreateSalePage> createState() => _CreateSalePageState();
}

class _CreateSalePageState extends State<CreateSalePage> {

  @override
  void initState() {
    super.initState();
    context.loaderOverlay.show();
  }

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
              headers: Constants.headers()
          );
        },
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
              name: 'WebViewMessage',
              onMessageReceived: (JavascriptMessage message) {
                if (message.message != '') {
                  Navigator.pop(context);
                }
              }
          ),
        },
        onPageFinished: (finish) {
          context.loaderOverlay.hide();
        },
      )
    );
  }
}
