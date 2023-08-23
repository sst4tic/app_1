import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/bloc/warehouse_arrival_bloc/warehouse_arrival_bloc.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/create_arrival_page.dart';
import '../../models /build_product_filter.dart';
import '../../models /build_warehouse_models.dart';
import '../../models /product_filter_model.dart';
import '../../util/function_class.dart';

class ProductsArrival extends StatefulWidget {
  const ProductsArrival({Key? key}) : super(key: key);

  @override
  State<ProductsArrival> createState() => _ProductsArrivalState();
}

class _ProductsArrivalState extends State<ProductsArrival> {
  final _arrivalBloc = WarehouseArrivalBloc();
  final ScrollController _sController = ScrollController();
  late final List<ProductFilterModel> filterData;
  bool isFilter = false;

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
  void didChangeDependencies() async {
    super.didChangeDependencies();
    filterData = await Func().getArrivalFilters();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WarehouseArrivalBloc>(
            create: (context) => WarehouseArrivalBloc(),
            child: BlocBuilder<WarehouseArrivalBloc, WarehouseArrivalState>(
              bloc: _arrivalBloc,
              builder: (context, state) {
                if (state is WarehouseArrivalLoading) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is WarehouseArrivalLoaded) {
                  return Scaffold(
                   appBar: AppBar(
                      title: const Text('Склад: приход'),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CreateArrivalPage()));
                          },
                          icon: const FaIcon(FontAwesomeIcons.plus),
                        ),
                        Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                showProductFilter(
                                  context: context,
                                  onSubmitted: (value) {
                                    _arrivalBloc.add(LoadArrival(filters: value));
                                  },
                                  isFilter: (val) => setState(() => isFilter = val),
                                  filterData: filterData,
                                  type: 'arrival'
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
                      ],
                    ),
                    body: buildArrival(
                        hasMore: state.hasMore,
                        context: context,
                        arrival: state.warehouseArrival,
                        onRefresh: () {
                          _arrivalBloc.add(LoadArrival());
                        },
                        controller: _sController),
                  );
                } else if (state is WarehouseArrivalLoadingFailure) {
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
            ));
  }
}
