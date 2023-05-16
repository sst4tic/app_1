import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:yiwucloud/util/barcode_model.dart';
import 'package:yiwucloud/util/styles.dart';
import '../bloc/scanner_bloc/scanner_bloc.dart';
import 'package:intl/intl.dart';

import '../util/painter_model.dart';

class InvoiceScanPage extends StatefulWidget {
  const InvoiceScanPage({Key? key}) : super(key: key);

  @override
  State<InvoiceScanPage> createState() => _InvoiceScanPageState();
}

class _InvoiceScanPageState extends State<InvoiceScanPage> {
  final List<BarcodeModel> barcodeList = [];
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String _scannedData = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (barcodeList.isNotEmpty) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Вы уверены что хотите покинуть страницу?'),
                  content: const Text(
                      'Если вы не сохраните данные они будут потеряны'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Нет')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop(barcodeList);
                        },
                        child: const Text('Да')),
                  ],
                );
              });
          return false;
        } else {
          Navigator.of(context).pop();
          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('QR Scanner'),
          ),
          body: BlocProvider<ScannerBloc>(
            create: (context) => ScannerBloc(),
            child: BlocBuilder<ScannerBloc, ScannerState>(
              builder: (context, state) {
                if (state is ScannerInitial) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Stack(
                          children: [
                            QRView(
                              key: qrKey,
                              onQRViewCreated: _onQRViewCreated,
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '|||',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 80),
                                    ),
                                    Text(
                                      '|||',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 80),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const CustomPaintContainer(),
                            if (_scannedData.isNotEmpty)
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    _scannedData,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
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
                        ),
                      ),
                      const Text(
                        'История сканирования :',
                        style: TextStyles.loginTitle,
                      ),
                      const SizedBox(height: 5),
                      buildInitial(),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('Error'),
                  );
                }
              },
            ),
          )),
    );
  }

  Widget buildInitial() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: barcodeList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(barcodeList[index].code),
            subtitle: Text(DateFormat('Добавлено в dd-MM-yy, в HH:mm')
                .format(barcodeList[index].date)
                .toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    if (barcodeList[index].count > 1) {
                      setState(() {
                        barcodeList[index].count--;
                      });
                    } else {
                      setState(() {
                        barcodeList.remove(barcodeList[index]);
                      });
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(barcodeList[index].count.toString()),
                IconButton(
                  onPressed: () {
                    setState(() {
                      barcodeList[index].count++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != '') {
        HapticFeedback.mediumImpact();
        setState(() {
          _scannedData = scanData.code!;
          if (barcodeList.any((element) => element.code == scanData.code)) {
            barcodeList
                .firstWhere((element) => element.code == scanData.code)
                .count++;
          } else {
            barcodeList.add(BarcodeModel(
              code: scanData.code!,
              date: DateTime.now(),
              count: 1,
            ));
          }
        });
        controller.pauseCamera();
        print(scanData);
        Future.delayed(const Duration(milliseconds: 500), () {
          controller.resumeCamera();
        });
      }
    });
  }
}
