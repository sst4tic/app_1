import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/warehouse_sales_bloc/warehouse_sales_bloc.dart';
import 'package:yiwucloud/util/filter_list_model.dart';
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
    return BlocProvider<WarehouseSalesBloc>(
        create: (context) => WarehouseSalesBloc(),
        child: BlocBuilder<WarehouseSalesBloc, WarehouseSalesState>(
          bloc: _salesBloc,
          builder: (context, state) {
            print(state);
            if (state is WarehouseSalesLoading) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Склад: продажи'),
                  ),
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ));
            } else if (state is WarehouseSalesLoaded) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Склад: продажи'),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(50.0),
                        child:
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Поиск',
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: Theme.of(context).scaffoldBackgroundColor,
                              contentPadding: const EdgeInsets.all(8),
                              enabledBorder:  const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onSubmitted: (value) {
                              _salesBloc.add(LoadWarehouseSales(query: value));
                            },
                          ),
                        ),
                      ),
                    // actions: [
                    //   IconButton(
                    //     onPressed: () async {
                    //       showFilter(
                    //           context: context,
                    //           filterData: filterData,
                    //           bloc: _salesBloc);
                    //     },
                    //     icon: const Icon(Icons.filter_alt),
                    //   ),
                    // ],
                  ),
                  body: buildSales(
                      onRefresh: () => _salesBloc.add(LoadWarehouseSales()),
                      context: context,
                      btnPermission: state.warehouseSales.btnPermission,
                      salesModel: state.warehouseSales.sales,
                      controller: _sController,
                      hasMore: state.hasMore));
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
        ));
  }
}
