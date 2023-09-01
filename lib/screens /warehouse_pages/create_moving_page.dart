import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/moving_details_page.dart';

import '../../util/constants.dart';

class CreateMovingPage extends StatefulWidget {
  const CreateMovingPage({Key? key}) : super(key: key);

  @override
  State<CreateMovingPage> createState() => _CreateMovingPageState();
}

class _CreateMovingPageState extends State<CreateMovingPage> {
  @override
  void initState() {
    super.initState();
    context.loaderOverlay.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Склад: Создание перемещения'),
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            webViewController.loadUrl(
                '${Constants.BASE_URL_DOMAIN}service/warehouse/products/moving/addition',
                headers: Constants.headers());
          },
          javascriptChannels: <JavascriptChannel>{
            JavascriptChannel(
                name: 'WebViewMessage',
                onMessageReceived: (JavascriptMessage message) {
                  if (message.message != '') {
                    var decodedMessage = jsonDecode(message.message);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovingDetailsPage(
                                  id: decodedMessage['moving_id'],
                                  movingId: decodedMessage['moving_number'])));
                    });
                  }
                }),
          },
          onPageFinished: (finish) {
            context.loaderOverlay.hide();
          },
        ));
  }
}
