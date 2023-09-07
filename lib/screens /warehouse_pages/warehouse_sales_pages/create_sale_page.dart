import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/warehouse_sales_details.dart';

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
            webViewController.loadUrl(
                '${Constants.BASE_URL_DOMAIN}service/warehouse/products/requests/addition',
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
                              builder: (context) => WareHouseSalesDetails(
                                  id: decodedMessage['invoice_id'],
                                  invoiceId:
                                      decodedMessage['invoice_number'])));
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
