import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:yiwucloud/bloc/multi_scan_bloc/multi_scan_bloc.dart';
import 'package:yiwucloud/models%20/multi_scan_model.dart';
import 'package:yiwucloud/util/constants.dart';
import '../../main.dart';
import '../../models /conditional_parent_widget.dart';

class MultiScanPage extends StatefulWidget {
  const MultiScanPage({Key? key}) : super(key: key);

  @override
  State<MultiScanPage> createState() => _MultiScanPageState();
}

class _MultiScanPageState extends State<MultiScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  final _invoiceScannerBloc = MultiScanBloc();

  @override
  void initState() {
    super.initState();
    _invoiceScannerBloc.add(LoadScanData());
    Constants.useragent == 'TC26' ? initInvoiceScanner() : null;
  }

  void initInvoiceScanner() {
    fdw.enableScanner(true);
    onScanResultListener = fdw.onScanResult.listen((result) {
      _invoiceScannerBloc
          .add(ScanEvent(context: context, barcode: result.data));
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
          body: BlocProvider<MultiScanBloc>(
            create: (context) => MultiScanBloc(),
            child: BlocBuilder<MultiScanBloc, MultiScanState>(
              bloc: _invoiceScannerBloc,
              builder: (context, state) {
                if (state is MultiScanLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MultiScanLoaded) {
                  final sortedData = List<MultiScanModel>.from(state.data!);
                  sortedData.sort((a, b) => a.qty == a.qtyScanned
                      ? 1
                      : a.qtyScanned == 0
                          ? -1
                          : 0);
                  return state.data!.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: Constants.useragent == 'TC26'
                                  ? 0
                                  : MediaQuery.of(context).size.height * 0.2,
                              child: Stack(
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
                              ),
                            ),
                            Padding(
                              padding: REdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  _invoiceScannerBloc
                                      .add(SubmitEvent(context: context));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 35.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Завершить'),
                              ),
                            ),
                            buildInitial(barcodeList: sortedData),
                          ],
                        )
                      : const Center(child: Text('Нет данных'));
                } else if (state is MultiScanError) {
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

  Widget buildInitial({required List<MultiScanModel> barcodeList}) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: REdgeInsets.all(8),
        itemCount: barcodeList.length,
        itemBuilder: (context, index) {
          final barcode = barcodeList[index];
          return Padding(
            padding: REdgeInsets.only(bottom: 8.0),
            child: ClipRect(
              clipBehavior: Clip.hardEdge,
              child: Slidable(
                dragStartBehavior: DragStartBehavior.down,
                enabled: barcode.qtyScanned != 0,
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.3,
                  children: [
                     SlidableAction(
                      onPressed: (context) {
                        _invoiceScannerBloc.add(DeleteEvent(
                          context: context,
                          index: index,
                        ));
                      },
                      label: 'Удалить',
                       spacing: 0,
                      backgroundColor: Colors.red,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    )
                  ],
                ),
                child: Container(
                  // margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        barcode.barcode,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                              '${barcode.qtyScanned.toString()} / ${barcode.qty.toString()}'),
                          const SizedBox(width: 8),
                          barcode.qtyScanned == barcode.qty
                              ? const Icon(
                                  FontAwesomeIcons.circleCheck,
                                  color: Colors.green,
                                  size: 16,
                                )
                              : const Icon(
                                  FontAwesomeIcons.circleXmark,
                                  color: Colors.red,
                                  size: 16,
                                ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool isScanned = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != '' && !isScanned) {
        isScanned = true;
        controller.pauseCamera();
        HapticFeedback.mediumImpact();
        _invoiceScannerBloc.add(ScanEvent(
          context: context,
          barcode: scanData.code!,
        ));
        Future.delayed(const Duration(milliseconds: 500), () {
          controller.resumeCamera();
          isScanned = false;
        });
      }
    });
  }
}
