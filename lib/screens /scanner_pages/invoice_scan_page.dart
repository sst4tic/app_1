import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:yiwucloud/util/box_scan_model.dart';
import 'package:yiwucloud/util/constants.dart';
import '../../bloc/invoice_scanner_bloc/invoice_scanner_bloc.dart';
import '../../main.dart';
import '../../models /conditional_parent_widget.dart';
import '../../util/invoice_scan_model.dart';
import '../../util/styles.dart';

class InvoiceScanPage extends StatefulWidget {
  const InvoiceScanPage({Key? key, required this.id, required this.invoiceId})
      : super(key: key);
  final int id;
  final String invoiceId;

  @override
  State<InvoiceScanPage> createState() => _InvoiceScanPageState();
}

class _InvoiceScanPageState extends State<InvoiceScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  final _invoiceScannerBloc = InvoiceScannerBloc();

  @override
  void initState() {
    super.initState();
    _invoiceScannerBloc.add(LoadScanData(id: widget.id));
    Constants.useragent == 'TC26' ? initInvoiceScanner() : null;
  }

  void initInvoiceScanner() {
    fdw.enableScanner(true);
    onScanResultListener = fdw.onScanResult.listen((result) {
      _invoiceScannerBloc.add(InvoiceScanEvent(
          id: widget.id, context: context, barcode: result.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalParentWidget(
      condition: (Constants.useragent == 'TC26' && Platform.isAndroid),
      conditionalBuilder: (Widget child) {
        return WillPopScope(
            child: child,
            onWillPop: () async {
              fdw.enableScanner(false);
              onScanResultListener.cancel();
              return true;
            });
      },
      child: Scaffold(
          appBar: AppBar(
              title: Text('Скан накладной №${widget.invoiceId}'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (Constants.useragent == 'TC26') {
                    fdw.enableScanner(false);
                    onScanResultListener.cancel();
                  }
                  Navigator.pop(context);
                },
              )),
          body: BlocProvider<InvoiceScannerBloc>(
            create: (context) => InvoiceScannerBloc(),
            child: BlocBuilder<InvoiceScannerBloc, InvoiceScannerState>(
              bloc: _invoiceScannerBloc,
              builder: (context, state) {
                if (state is InvoiceScannerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is InvoiceScannerLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Stack(
                          children: Constants.useragent == 'TC26'
                              ? [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.barcode,
                                        size: 120,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(height: 20.h),
                                      const Text(
                                        'Нажмите кнопку на ТСД, чтобы начать сканирование',
                                        textAlign: TextAlign.center,
                                        style: TextStyles.loginTitle,
                                      ),
                                    ],
                                  )
                                ]
                              : [
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
                        ),
                      ),
                      Padding(
                        padding:
                            REdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: Size(double.infinity, 30.h),
                          ),
                          onPressed: () {
                            _invoiceScannerBloc.add(InvoiceInputEvent(
                                id: widget.id,
                                context: context,
                                type: state.type));
                          },
                          child: const Text('Ввести вручную'),
                        ),
                      ),
                      state.box != null
                          ? Padding(
                              padding: REdgeInsets.all(8.0),
                              child: buildBox(box: state.box!),
                            )
                          : buildInitial(barcodeList: state.products!),
                    ],
                  );
                } else if (state is InvoiceScannerError) {
                  return Text(state.exception.toString());
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

  Widget buildInitial({required List<InvoiceScanModel> barcodeList}) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: REdgeInsets.all(8),
        itemCount: barcodeList.length,
        itemBuilder: (context, index) {
          final barcode = barcodeList[index];
          final availabilityString = barcode.availability
                  ?.where((item) => item.location != '')
                  .map((item) => '${item.name} | ${item.location}')
                  .join('\n') ??
              'Нет в наличии';
          return Container(
            padding: REdgeInsets.all(8),
            margin: REdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${barcode.name} / ${barcode.sku}',
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  availabilityString,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Нужно отсканировать:',
                      style: TextStyle(fontSize: 14),
                    ),
                    barcode.qty >= 5
                        ? Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  _invoiceScannerBloc.add(
                                    InvoiceScanQtyEvent(
                                      id: widget.id,
                                      barcode: barcode.sku,
                                      context: context,
                                      qty: barcode.qtyScanned - 1,
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  _invoiceScannerBloc.add(
                                    InvoiceScanInputQtyEvent(
                                      id: widget.id,
                                      barcode: barcode.sku,
                                      context: context,
                                      qty: barcode.qtyScanned,
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[300],
                                  ),
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    '${barcode.qtyScanned} / ${barcode.qty}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  _invoiceScannerBloc.add(
                                    InvoiceScanEvent(
                                      id: widget.id,
                                      barcode: barcode.sku,
                                      context: context,
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : Text(
                            '${barcode.qtyScanned} / ${barcode.qty}',
                            style: const TextStyle(fontSize: 14),
                          ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildBox({required BoxScanModel box}) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            box.barcode,
            maxLines: 2,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Нужно отсканировать: ${box.qtyScanned} / ${box.qty}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  bool isScanned = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != '' && !isScanned) {
        isScanned = true;
        controller.pauseCamera();
        HapticFeedback.mediumImpact();
        _invoiceScannerBloc.add(InvoiceScanEvent(
            id: widget.id, context: context, barcode: scanData.code!));
        Future.delayed(const Duration(milliseconds: 500), () {
          controller.resumeCamera();
          isScanned = false;
        });
      }
    });
  }
}
