import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/bloc/warehouse_moving_bloc/warehouse_moving_bloc.dart';
import 'package:yiwucloud/models%20/build_product_filter.dart';
import 'package:yiwucloud/models%20/build_warehouse_models.dart';
import 'package:yiwucloud/util/constants.dart';
import '../../models /product_filter_model.dart';
import '../../models /search_model.dart';
import '../../util/function_class.dart';
import '../create_moving_page.dart';

class ProductsMoving extends StatefulWidget {
  const ProductsMoving({Key? key}) : super(key: key);

  @override
  State<ProductsMoving> createState() => _ProductsMovingState();
}

class _ProductsMovingState extends State<ProductsMoving> {
  final _movingBloc = WarehouseMovingBloc();
  final ScrollController _sController = ScrollController();
  late final List<ProductFilterModel> filterData;

  @override
  void initState() {
    super.initState();
    _movingBloc.add(LoadMoving());
    _sController.addListener(() {
      if (_sController.position.pixels ==
          _sController.position.maxScrollExtent) {
        _movingBloc.add(LoadMore());
      }
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    filterData = await Func().getMovingFilters();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WarehouseMovingBloc>(
          create: (context) => WarehouseMovingBloc(),
          child: BlocBuilder<WarehouseMovingBloc, WarehouseMovingState>(
            bloc: _movingBloc,
            builder: (context, state) {
              if (state is WarehouseMovingLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is WarehouseMovingLoaded) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Склад: перемещение'),
                    bottom: searchModel(
                        context: context,
                        onSubmitted: (value) =>
                            _movingBloc.add(LoadMoving(query: value))),
                    actions: [
                      IconButton(
                        onPressed: () {
                          showProductFilter(
                            context: context,
                            onSubmitted: (value) {
                              _movingBloc.add(LoadMoving(filters: value));
                            }, filterData: filterData,
                          );
                        },
                        icon: const Icon(Icons.filter_alt),
                      ),
                      Constants.movingPermission ? IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateMovingPage()));
                        },
                        icon: const FaIcon(FontAwesomeIcons.plus),
                      ) : const SizedBox(),
                    ],
                  ),
                  body: RefreshIndicator(
                    onRefresh: () async {
                      _movingBloc.add(LoadMoving());
                    },
                    child: buildMoving(
                        hasMore: state.hasMore,
                        moving: state.warehouseMoving,
                        controller: _sController,
                        context: context),
                  ),
                );
              } else if (state is WarehouseMovingLoadingFailure) {
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
}
