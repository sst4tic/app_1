import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/models%20/barcode_scanner_model.dart';
import 'package:yiwucloud/util/constants.dart';
import 'package:yiwucloud/util/function_class.dart';
import 'package:yiwucloud/util/styles.dart';
import '../bloc/global_scanner_bloc/scanner_bloc.dart';
import '../models /custom_dialogs_model.dart';
import 'global_scan_screen.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  @override
  void initState() {
    super.initState();
    Func().initGlobalScanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('YIWU Scanner'),
        ),
        body: BlocProvider<ScannerBloc>(
          create: (context) => ScannerBloc(),
          child: BlocBuilder<ScannerBloc, ScannerState>(
            builder: (context, state) {
              if (state is ScannerInitial) {
                return Constants.useragent == 'TC26'
                    ? Column(
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
                    : Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: const QRScanner(),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 8.0),
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final qtyController = TextEditingController();
                                    return CustomAlertDialog(
                                        title: 'Ввести в ручную',
                                        content: CustomTextField(
                                          controller: qtyController,
                                          placeholder: 'Введите число',
                                        ),
                                        actions: [
                                          CustomDialogAction(
                                            text: 'Отмена',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          CustomDialogAction(
                                            text: 'Подтвердить',
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  fullscreenDialog: true,
                                                  builder: (context) =>
                                                      GlobalScanScreen(
                                                    scanData: qtyController.text,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ]);
                                  },
                                );
                              },
                              child: const Text('Ввести вручную'),
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            'Наведите камеру на QR-код или \n Баркод чтобы начать сканирование.',
                            textAlign: TextAlign.center,
                            style: TextStyles.loginTitle,
                          ),
                          SizedBox(height: 30.h),
                        ],
                      );
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            },
          ),
        ));
  }
}
