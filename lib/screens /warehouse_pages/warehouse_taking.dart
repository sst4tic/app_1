import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/models%20/search_model.dart';
import '../../bloc/warehouse_taking_bloc/warehouse_taking_bloc.dart';
import '../../models /build_filter.dart';
import '../../models /build_warehouse_models.dart';
import '../../models /warehouse_taking_widget_model.dart';
import '../../util/filter_list_model.dart';
import '../../util/function_class.dart';
import 'multi_scan_page.dart';

class WarehouseTaking extends StatefulWidget {
  const WarehouseTaking({Key? key}) : super(key: key);

  @override
  State<WarehouseTaking> createState() => _WarehouseTakingState();
}

class _WarehouseTakingState extends State<WarehouseTaking>
    with TickerProviderStateMixin {
  final _takingBloc = WarehouseTakingBloc();
  TabController? _tabController;
  final ScrollController _sController = ScrollController();
  final ScrollController _sControllerCompleted = ScrollController();
  bool isFilter = false;

  @override
  void initState() {
    super.initState();
    _takingBloc.add(LoadWarehouseTaking());
    _tabController = TabController(length: 3, vsync: this);
    _sController.addListener(() {
      if (_sController.position.pixels ==
          _sController.position.maxScrollExtent) {
        _takingBloc.add(LoadMore());
      }
    });
    _sControllerCompleted.addListener(() {
      if (_sControllerCompleted.position.pixels ==
          _sControllerCompleted.position.maxScrollExtent) {
        _takingBloc.add(LoadMoreCompleted());
      }
    });
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MultiScanPage()));
              },
              icon: const Icon(Icons.qr_code_scanner),
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    showFilter(
                        context: context,
                        isFilter: (val) => isFilter = val,
                        onSubmitted: (filter) =>
                            _takingBloc.add(LoadWarehouseTaking(filters: filter)),
                        filterData: filterData);
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
                    Tab(text: 'Перемещения')
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
                              _takingBloc.add(LoadWarehouseTaking()),
                          total: state.totalCount,
                          sController: _sController,
                          hasMore: state.hasMore),
                      buildTakingList(
                          taking: state.warehouseCompleted,
                          onRefresh: () =>
                              _takingBloc.add(LoadWarehouseTaking()),
                          total: state.totalCountCompleted,
                          sController: _sControllerCompleted,
                          hasMore: state.hasMoreCompleted),
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
