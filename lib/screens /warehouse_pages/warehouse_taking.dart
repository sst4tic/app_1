import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/models%20/search_model.dart';
import '../../bloc/warehouse_taking_bloc/warehouse_taking_bloc.dart';
import '../../models /build_filter.dart';
import '../../models /warehouse_taking_widget_model.dart';
import '../../util/filter_list_model.dart';
import '../../util/function_class.dart';

class WarehouseTaking extends StatefulWidget {
  const WarehouseTaking({Key? key}) : super(key: key);

  @override
  State<WarehouseTaking> createState() => _WarehouseTakingState();
}

class _WarehouseTakingState extends State<WarehouseTaking>
    with TickerProviderStateMixin {
  final _takingBloc = WarehouseTakingBloc();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _takingBloc.add(LoadWarehouseTaking());
    _tabController = TabController(length: 2, vsync: this);
  }

  late final FilterModel filterData;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    filterData = await Func().getFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Склад: Вывоз'),
          actions: [
            IconButton(
              onPressed: () {
                showFilter(
                    context: context,
                    onSubmitted: (filter) =>
                        _takingBloc.add(LoadWarehouseTaking(filters: filter)),
                    filterData: filterData);
              },
              icon: const Icon(Icons.filter_alt),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Column(
              children: [
                searchModel(
                    context: context,
                    onSubmitted: (value) =>
                        _takingBloc.add(LoadWarehouseTaking(query: value))),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.blue,
                  tabs: const [
                    Tab(text: 'Вывоз'),
                    Tab(text: 'Отпущено'),
                  ],
                ),
              ],
            ),
          )),
      body: BlocProvider<WarehouseTakingBloc>(
        create: (context) => WarehouseTakingBloc(),
        child: BlocBuilder<WarehouseTakingBloc, WarehouseTakingState>(
          bloc: _takingBloc,
          builder: (context, state) {
            if (state is WarehouseTakingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WarehouseTakingLoaded) {
              return DefaultTabController(
                  length: 2,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildTakingList(
                          taking: state.warehouseTaking,
                          onRefresh: () =>
                              _takingBloc.add(LoadWarehouseTaking())),
                      buildTakingList(
                          taking: state.warehouseCompleted,
                          onRefresh: () =>
                              _takingBloc.add(LoadWarehouseTaking())),
                    ],
                  ));
            } else {
              return const Center(child: Text('Ошибка'));
            }
          },
        ),
      ),
    );
  }
}
