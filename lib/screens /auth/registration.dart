import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      body:  WebView(
        onPageStarted: (String url) {
          context.loaderOverlay.show();
        },
        onPageFinished: (String url) {
          context.loaderOverlay.hide();
        },
        initialUrl: 'https://cloud.yiwumart.org/api/registration',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
