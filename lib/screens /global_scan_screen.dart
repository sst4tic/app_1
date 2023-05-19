import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/product_detail.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/warehouse_sales_details.dart';
import 'package:yiwucloud/util/styles.dart';
import '../bloc/scan_result_bloc/scan_resullt_bloc.dart';

class GlobalScanScreen extends StatefulWidget {
  const GlobalScanScreen({Key? key, required this.scanData}) : super(key: key);
  final String scanData;

  @override
  State<GlobalScanScreen> createState() => _GlobalScanScreenState();
}

class _GlobalScanScreenState extends State<GlobalScanScreen> {
  final _scanResultBloc = ScanResultBloc();

  @override
  void initState() {
    super.initState();
    _scanResultBloc.add(CheckScanResult(widget.scanData, context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocProvider<ScanResultBloc>(
          create: (context) => ScanResultBloc(),
          child: BlocBuilder<ScanResultBloc, ScanResultState>(
            bloc: _scanResultBloc,
            builder: (context, state) {
              if (state is ScanResultLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ScanResultProduct) {
                return ProductDetail(id: state.id);
              } else if (state is ScanResultInvoice) {
                return WareHouseSalesDetails(
                  invoiceId: state.invoiceId,
                  id: state.id,
                );
              } else if (state is ScanResultLoadingFailure) {
                return Center(
                    child: Container(
                        height: 100.h,
                        padding: REdgeInsets.all(8),
                        margin: REdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Такого баркода нет в базе данных',
                              style: TextStyles.loginTitle,
                            ),
                            SizedBox(height: 10.h),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // minimumSize: Size(200.w, 30.h),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Повторить сканирование'))
                          ],
                        )));
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
