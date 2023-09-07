import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../util/constants.dart';

class UserListEditPage extends StatefulWidget {
  const UserListEditPage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<UserListEditPage> createState() => _UserListEditPageState();
}

class _UserListEditPageState extends State<UserListEditPage> {
  @override
  void initState() {
    super.initState();
    context.loaderOverlay.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактирование пользователя'),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          webViewController.loadUrl(widget.url,
              headers: Constants.headers()
          );
        },
        onPageFinished: (finish) {
          context.loaderOverlay.hide();
        },
      )
    );
  }
}
