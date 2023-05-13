import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/product_detail.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/warehouse_sales_details.dart';
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
              child: Text(state.exception.toString()),
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
