import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/models%20/barcode_scanner_model.dart';
import 'package:yiwucloud/util/constants.dart';
import 'package:yiwucloud/util/function_class.dart';
import 'package:yiwucloud/util/styles.dart';
import '../bloc/global_scanner_bloc/scanner_bloc.dart';

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
                          const  FaIcon(
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
