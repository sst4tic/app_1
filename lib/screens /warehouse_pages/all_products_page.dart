import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/models%20/build_filter.dart';
import 'package:yiwucloud/models%20/search_model.dart';
import '../../bloc/products_bloc/products_bloc.dart';
import '../../models /build_warehouse_models.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({Key? key}) : super(key: key);

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  final productsBloc = ProductsBloc();
  final ScrollController _sController = ScrollController();

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
          IconButton(
            onPressed: () {
              showFilter(context: context, productBloc: productsBloc);
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
        title: const Text('Все товары'),
        bottom: searchModel(context),
      ),
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
                  products: state.products, controller: _sController);
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
