import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/warehouse_sales_bloc/warehouse_sales_bloc.dart';
import 'package:yiwucloud/models%20/search_model.dart';
import 'package:yiwucloud/util/filter_list_model.dart';
import '../../../models /build_filter.dart';
import '../../../models /build_warehouse_models.dart';
import '../../../util/function_class.dart';

class WarehouseSales extends StatefulWidget {
  const WarehouseSales({Key? key}) : super(key: key);

  @override
  State<WarehouseSales> createState() => _WarehouseSalesState();
}

class _WarehouseSalesState extends State<WarehouseSales> {
  final _salesBloc = WarehouseSalesBloc();
  final ScrollController _sController = ScrollController();
  late final FilterModel filterData;

  @override
  void initState() {
    super.initState();
    _salesBloc.add(LoadWarehouseSales());
    _sController.addListener(() {
      if (_sController.position.pixels ==
          _sController.position.maxScrollExtent) {
        _salesBloc.add(LoadMore());
      }
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    filterData = await Func().getFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Склад: продажи'),
        bottom: searchModel(context: context, onSubmitted: (value) => _salesBloc.add(LoadWarehouseSales(query: value))),
        actions: [
          IconButton(
            onPressed: () {
              showFilter(
                  context: context,
                  filterData: filterData,
                  onSubmitted: (value) {
                    _salesBloc.add(LoadWarehouseSales(filters: value));
                  });
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
      ),
      body: BlocProvider<WarehouseSalesBloc>(
          create: (context) => WarehouseSalesBloc(),
          child: BlocBuilder<WarehouseSalesBloc, WarehouseSalesState>(
            bloc: _salesBloc,
            builder: (context, state) {
              if (state is WarehouseSalesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WarehouseSalesLoaded) {
                return buildSales(
                    onRefresh: () => _salesBloc.add(LoadWarehouseSales()),
                    context: context,
                    btnPermission: state.warehouseSales.btnPermission,
                    salesModel: state.warehouseSales.sales,
                    controller: _sController,
                    hasMore: state.hasMore);
              } else if (state is WarehouseSalesLoadingFailure) {
                return Center(
                  child: Text(state.exception.toString()),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            },
          )),
    );
  }
}
