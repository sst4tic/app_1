import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:yiwucloud/models%20/search_model.dart';
import '../../bloc/products_bloc/products_bloc.dart';
import '../../models /build_product_filter.dart';
import '../../models /build_warehouse_models.dart';
import '../../models /product_filter_model.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({Key? key}) : super(key: key);

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  final productsBloc = ProductsBloc();
  final ScrollController _sController = ScrollController();
  bool isFilter = false;
  final productFilterBox = Hive.box<List<ProductFilterModel>>('product_filter');

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () async {
                    showProductFilter(
                      context: context,
                      filterData: productFilterBox.get('product_filter') ?? [],
                      onSubmitted: (value) {
                        productsBloc.add(LoadProducts(filters: value));
                      },
                      isFilter: (val) => setState(() => isFilter = val),
                      type: 'all_products'
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
