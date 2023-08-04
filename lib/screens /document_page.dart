import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({Key? key, required this.document}) : super(key: key);
  final String document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Документ'),
        actions: [
          IconButton(
            onPressed: () {
              Share.share(document);
            },
            icon: const Icon(Icons.share),
          )
        ],
      ),
      body: document.contains('.pdf')
          ? WebView(
        onPageStarted: (value) {
          context.loaderOverlay.show();
        },
        onPageFinished: (value) {
          context.loaderOverlay.hide();
        },
        initialUrl: document,
        javascriptMode: JavascriptMode.unrestricted,
      )
          :
      ExtendedImage.network(
        document,
        fit: BoxFit.fill,
        cache: true,
        width: double.infinity,
        height: double.infinity,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        //cancelToken: cancellationToken,
      )
    );
  }
}
