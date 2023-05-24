import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/models%20/barcode_scanner_model.dart';
import 'package:yiwucloud/util/barcode_model.dart';
import 'package:yiwucloud/util/styles.dart';
import '../bloc/global_scanner_bloc/scanner_bloc.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final List<BarcodeModel> barcodeList = [];

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
                return Column(
                  children: [
                     SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
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

  Widget buildInitial() {
    return ListView(
      padding: REdgeInsets.all(8.0),
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.keyboard_alt_outlined),
          onPressed: () {
          },
          label: const Text('Ввести в ручную'),
        ),
        const SizedBox(height: 10),
        const Text(
          'История сканирования :',
          style: TextStyles.loginTitle,
        ),
        const SizedBox(height: 5),
        // Expanded(
        //   child: ListView.builder(
        //     physics: const BouncingScrollPhysics(),
        //     shrinkWrap: true,
        //     padding: const EdgeInsets.all(8),
        //     itemCount: barcodeList.length,
        //     itemBuilder: (context, index) {
        //       return ListTile(
        //         title: Text(barcodeList[index].code),
        //         subtitle: Text(DateFormat('Добавлено в dd-MM-yy, в HH:mm')
        //             .format(barcodeList[index].date)
        //             .toString()),
        //         trailing: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             IconButton(
        //               onPressed: () {
        //                 if (barcodeList[index].count > 1) {
        //                   setState(() {
        //                     barcodeList[index].count--;
        //                   });
        //                 } else {
        //                   setState(() {
        //                     barcodeList.remove(barcodeList[index]);
        //                   });
        //                 }
        //               },
        //               icon: const Icon(Icons.remove),
        //             ),
        //             Text(barcodeList[index].count.toString()),
        //             IconButton(
        //               onPressed: () {
        //                 setState(() {
        //                   barcodeList[index].count++;
        //                 });
        //               },
        //               icon: const Icon(Icons.add),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
