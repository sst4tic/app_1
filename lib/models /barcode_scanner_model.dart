import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:yiwucloud/screens%20/global_scan_screen.dart';
class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  QRScannerState createState() => QRScannerState();
}

class QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String _scannedData = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QRView(
          overlay: QrScannerOverlayShape(
            borderColor: Colors.green,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutHeight: 150,
            cutOutWidth: 300,
          ),
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: IconButton(
            icon: const Icon(
              Icons.flash_on,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                controller.toggleFlash();
              });
            },
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _scannedData = scanData.code!;
      });
      if (scanData != '') {
        HapticFeedback.mediumImpact();
        controller.pauseCamera();
        Navigator.push(
          context,
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => GlobalScanScreen(
              scanData: scanData.code!,
            ),
          ),
        ).then((value) => controller.resumeCamera());
      }
    });
  }
}
