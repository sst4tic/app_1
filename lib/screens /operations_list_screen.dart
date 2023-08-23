import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/models%20/build_warehouse_models.dart';
import 'package:yiwucloud/models%20/operations_model.dart';

import '../bloc/operations_list_bloc/operations_list_bloc.dart';
import '../models /build_product_filter.dart';
import '../models /product_filter_model.dart';
import '../util/function_class.dart';
import '../util/styles.dart';
import 'operation_creating_page.dart';

class OperationsListPage extends StatefulWidget {
  const OperationsListPage({Key? key}) : super(key: key);

  @override
  State<OperationsListPage> createState() => _OperationsListPageState();
}

class _OperationsListPageState extends State<OperationsListPage> {
  final _operationsListBloc = OperationsListBloc();
  final ScrollController _sController = ScrollController();
  late final List<ProductFilterModel> filterData;
  bool isFilter = false;

  @override
  void initState() {
    super.initState();
    _operationsListBloc.add(LoadOperations());
    _sController.addListener(() {
      if (_sController.position.pixels ==
          _sController.position.maxScrollExtent) {
        _operationsListBloc.add(LoadMore());
      }
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    filterData = await Func().getOperationFilters();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OperationsListBloc>(
      create: (context) => OperationsListBloc(),
      child: BlocBuilder<OperationsListBloc, OperationsListState>(
        bloc: _operationsListBloc,
        builder: (context, state) {
          if (state is OperationsListLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is OperationsListLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Операции'),
                actions: [
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          showProductFilter(
                            context: context,
                            onSubmitted: (value) {
                              _operationsListBloc
                                  .add(LoadOperations(filters: value));
                            },
                            isFilter: (val) => setState(() => isFilter = val),
                            filterData: filterData,
                            type: 'operations',
                          );
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
                  IconButton(
                      onPressed: () => bottomSheet(state.operationsList),
                      icon: const Icon(Icons.more_horiz)),
                ],
              ),
              body: buildOperations(
                  operationModel: state.operationsList,
                  controller: _sController,
                  context: context,
                  onRefresh: () {
                    _operationsListBloc.add(LoadOperations());
                  },
                  hasMore: state.hasMore),
            );
          } else if (state is OperationsListLoadingFailure) {
            return Scaffold(
              body: Center(
                child: Text(state.exception.toString()),
              ),
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }

  bottomSheet(OperationModel operationModel) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return Container(
            padding: REdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            height: 200,
            child: Column(
              children: [
                const Text(
                  'Дополнительные действия',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8.h,
                ),
                ListTile(
                  trailing: const Icon(FontAwesomeIcons.arrowRightArrowLeft),
                  title: Text(
                    'Создать перемещние',
                    style: TextStyles.editStyle.copyWith(fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OperationCreatingPage(
                                type: 'create_moving')));
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                ListTile(
                  trailing: const Icon(FontAwesomeIcons.sliders),
                  title: Text(
                    'Создать операцию',
                    style: TextStyles.editStyle.copyWith(fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OperationCreatingPage(
                                type: 'create_operation')));
                  },
                ),
              ],
            ),
          );
        });
  }
}
