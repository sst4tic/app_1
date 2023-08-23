import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/models%20/build_filter.dart';
import 'package:yiwucloud/models%20/build_warehouse_models.dart';
import 'package:yiwucloud/models%20/search_model.dart';
import 'package:yiwucloud/models%20/warehouse_taking_widget_model.dart';
import 'package:yiwucloud/util/filter_list_model.dart';
import '../../bloc/warehouse_assembly_bloc/warehouse_assembly_bloc.dart';
import '../../util/function_class.dart';

class WarehouseAssembly extends StatefulWidget {
  const WarehouseAssembly({Key? key}) : super(key: key);

  @override
  State<WarehouseAssembly> createState() => _WarehouseAssemblyState();
}

class _WarehouseAssemblyState extends State<WarehouseAssembly>
    with TickerProviderStateMixin {
  final _assemblyBloc = WarehouseAssemblyBloc();
  late final FilterModel filterData;
  TabController? _tabController;
  final ScrollController _sController = ScrollController();
  final ScrollController _sControllerPostponed = ScrollController();
  bool isFilter = false;
  @override
  void initState() {
    super.initState();
    _assemblyBloc.add(LoadWarehouseAssembly());
    _tabController = TabController(length: 3, vsync: this);
    _sController.addListener(() {
      if (_sController.position.pixels ==
          _sController.position.maxScrollExtent) {
        _assemblyBloc.add(LoadMore());
      }
    });
    _sControllerPostponed.addListener(() {
      if (_sControllerPostponed.position.pixels ==
          _sControllerPostponed.position.maxScrollExtent) {
        _assemblyBloc.add(LoadMorePostponed());
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
          title: const Text('Склад: Сборка'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Column(
              children: [
                searchModel(
                    context: context,
                    onSubmitted: (value) =>
                        _assemblyBloc.add(LoadWarehouseAssembly(query: value))),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.blue,
                  tabs: const [
                    Tab(text: 'Сборка'),
                    Tab(text: 'Отложенные'),
                    Tab(text: 'Перемещения'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    showFilter(
                        context: context,
                        filterData: filterData,
                        isFilter: (val) => isFilter = val,
                        onSubmitted: (filter) => _assemblyBloc
                            .add(LoadWarehouseAssembly(filters: filter)));
                  },
                  icon: const Icon(Icons.filter_alt),
                ),
                if (isFilter)
                  Positioned(
                    right: 10,
                    bottom: 27,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 9,
                        minHeight: 9,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        body: BlocProvider<WarehouseAssemblyBloc>(
          create: (context) => WarehouseAssemblyBloc(),
          child: BlocBuilder<WarehouseAssemblyBloc, WarehouseAssemblyState>(
            bloc: _assemblyBloc,
            builder: (context, state) {
              if (state is WarehouseAssemblyLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WarehouseAssemblyLoaded) {
                return DefaultTabController(
                  length: 3,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildTakingList(
                          taking: state.warehouseAssembly,
                          hasMore: state.hasMore,
                          sController: _sController,
                          total: state.totalCount,
                          onRefresh: () =>
                              _assemblyBloc.add(LoadWarehouseAssembly())),
                      buildTakingList(
                          taking: state.warehouseAssemblyPostponed,
                          hasMore: state.hasMorePostponed,
                          sController: _sControllerPostponed,
                          total: state.totalCountPostponed,
                          onRefresh: () =>
                              _assemblyBloc.add(LoadWarehouseAssembly())),
                      state.movingList.isNotEmpty
                          ? buildMoving(
                              hasMore: false,
                              moving: state.movingList,
                              controller: ScrollController(),
                              context: context)
                          : const Center(
                              child: Text('Нет перемещений'),
                            ),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('Ошибка'));
              }
            },
          ),
        ));
  }
}
