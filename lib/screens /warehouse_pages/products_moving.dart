import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/warehouse_moving_bloc/warehouse_moving_bloc.dart';
import 'package:yiwucloud/models%20/build_warehouse_models.dart';
import '../../models /search_model.dart';

class ProductsMoving extends StatefulWidget {
  const ProductsMoving({Key? key}) : super(key: key);

  @override
  State<ProductsMoving> createState() => _ProductsMovingState();
}

class _ProductsMovingState extends State<ProductsMoving> {
  final _movingBloc = WarehouseMovingBloc();
  final ScrollController _sController = ScrollController();

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Склад: перемещение'),
          bottom: searchModel(context),
        ),
        body: BlocProvider<WarehouseMovingBloc>(
          create: (context) => WarehouseMovingBloc(),
          child: BlocBuilder<WarehouseMovingBloc, WarehouseMovingState>(
            bloc: _movingBloc,
            builder: (context, state) {
              if (state is WarehouseMovingLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WarehouseMovingLoaded) {
                return buildMoving(
                    moving: state.warehouseMoving, controller: _sController);
              } else if (state is WarehouseMovingLoadingFailure) {
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
