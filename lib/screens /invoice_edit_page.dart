import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../util/constants.dart';

class InvoiceEditPage extends StatefulWidget {
  const InvoiceEditPage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<InvoiceEditPage> createState() => _InvoiceEditPageState();
}

class _InvoiceEditPageState extends State<InvoiceEditPage> {

  @override
  void initState() {
    super.initState();
    context.loaderOverlay.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Редактирование накладной'),
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            webViewController.loadUrl(widget.url,
                headers: Constants.headers()
            );
          },
          javascriptChannels: <JavascriptChannel>{
            JavascriptChannel(
                name: 'WebViewMessage',
                onMessageReceived: (JavascriptMessage message) {
                  if (message.message != '') {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.pop(context);
                    });
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
