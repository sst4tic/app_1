import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/models%20/search_model.dart';
import '../../bloc/products_bloc/products_bloc.dart';
import '../../models /build_product_filter.dart';
import '../../models /build_warehouse_models.dart';
import '../../models /product_filter_model.dart';
import '../../util/function_class.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({Key? key}) : super(key: key);

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  final productsBloc = ProductsBloc();
  final ScrollController _sController = ScrollController();
  late final List<ProductFilterModel> filterData;

  @override
  void initState() {
    super.initState();
    productsBloc.add(LoadProducts());
    _sController.addListener(() {
      if (_sController.position.pixels ==
          _sController.position.maxScrollExtent) {
        productsBloc.add(LoadMore());
      }
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    filterData = await Func().getProductsFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                showProductFilter(
                  context: context,
                  filterData: filterData,
                  onSubmitted: (value) {
                    productsBloc.add(LoadProducts(filters: value));
                  },
                );
              },
              icon: const Icon(Icons.filter_alt),
            ),
          ],
          title: const Text('Все товары'),
          bottom: searchModel(
              context: context,
              onSubmitted: (value) =>
                  productsBloc.add(LoadProducts(query: value)))),
      body: BlocProvider<ProductsBloc>(
        create: (context) => ProductsBloc(),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          bloc: productsBloc,
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductsLoaded) {
              return buildProducts(
                  hasMore: state.hasMore,
                  products: state.products,
                  controller: _sController);
            } else if (state is ProductsLoadingFailure) {
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
      ),
    );
  }
}
