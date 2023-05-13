import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/warehouse_arrival_bloc/warehouse_arrival_bloc.dart';
import '../../models /build_warehouse_models.dart';
import '../../models /search_model.dart';

class ProductsArrival extends StatefulWidget {
  const ProductsArrival({Key? key}) : super(key: key);

  @override
  State<ProductsArrival> createState() => _ProductsArrivalState();
}

class _ProductsArrivalState extends State<ProductsArrival> {
  final _arrivalBloc = WarehouseArrivalBloc();
  final ScrollController _sController = ScrollController();

  @override
  void initState() {
    super.initState();
    _arrivalBloc.add(LoadArrival());
    _sController.addListener(() {
      if (_sController.position.pixels ==
          _sController.position.maxScrollExtent) {
        _arrivalBloc.add(LoadMore());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Склад: приход'),
          bottom: searchModel(context),
        ),
        body: BlocProvider<WarehouseArrivalBloc>(
            create: (context) => WarehouseArrivalBloc(),
            child: BlocBuilder<WarehouseArrivalBloc, WarehouseArrivalState>(
              bloc: _arrivalBloc,
              builder: (context, state) {
                if (state is WarehouseArrivalLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WarehouseArrivalLoaded) {
                  return buildArrival(
                    context: context,
                      arrival: state.warehouseArrival,
                      controller: _sController);
                } else if (state is WarehouseArrivalLoadingFailure) {
                  return Center(
                    child: Text(state.exception.toString()),
                  );
                } else {
                  return const Center(
                    child: Text('Error'),
                  );
                }
              },
            )));
  }
}
