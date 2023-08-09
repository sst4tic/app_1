import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/bloc/warehouse_sales_bloc/warehouse_sales_bloc.dart';
import 'package:yiwucloud/models%20/search_model.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/create_sale_page.dart';
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

  void onAppBarTap() {
    _sController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
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
          if (state is WarehouseSalesLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is WarehouseSalesLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Склад: продажи'),
                flexibleSpace: GestureDetector(
                  onTap: onAppBarTap,
                ),
                bottom: searchModel(
                    context: context,
                    onSubmitted: (value) =>
                        _salesBloc.add(LoadWarehouseSales(query: value))),
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
                  state.warehouseSales.btnPermission == true
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateSalePage()),
                            );
                          },
                          icon: const FaIcon(FontAwesomeIcons.plus),
                        )
                      : const SizedBox(),
                ],
              ),
              body: buildSales(
                  onRefresh: () => _salesBloc.add(LoadWarehouseSales()),
                  context: context,
                  btnPermission: state.warehouseSales.btnPermission,
                  salesModel: state.warehouseSales.sales,
                  controller: _sController,
                  total: state.warehouseSales.total,
                  hasMore: state.hasMore),
            );
          } else if (state is WarehouseSalesLoadingFailure) {
            return Scaffold(
              body: Center(
                child: Text(state.exception.toString()),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
