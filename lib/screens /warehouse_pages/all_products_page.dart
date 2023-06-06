import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       final filterData = await Func().getFilters();
        //       showFilter(context: context, filterData: filterData, bloc: productsBloc);
        //     },
        //     icon: const Icon(Icons.filter_alt),
        //   ),
        // ],
        title: const Text('Все товары'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child:
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Поиск',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                contentPadding: const EdgeInsets.all(8),
                enabledBorder:  const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onSubmitted: (value) {
                productsBloc.add(LoadProducts(query: value));
              },
            ),
          ),
        ),
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
                hasMore: state.hasMore,
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
