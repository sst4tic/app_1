import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/products_bloc/products_bloc.dart';
import '../../util/product.dart';

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
        print('end');
        productsBloc.add(LoadMore());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все товары'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: Padding(
            padding: REdgeInsets.only(
              left: 11,
              right: 11,
              bottom: 10,
            ),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                readOnly: true,
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
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
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
              return buildProducts(state.products);
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

  Widget buildProducts(List<Product> products) {
    return CustomScrollView(
      controller: _sController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return const Divider(height: 0);
            },
            childCount: 1,
          ),
        ),
        SliverToBoxAdapter(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(
                  product.name,
                  maxLines: 1,
                ),
                subtitle: Text(product.categoryName!),
                trailing: Text('${product.price.toString()} ₸'),
                leading: Text(
                  (index + 1).toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 0,
              );
            },
          ),
        ),
        BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadingMore) {
              return const SliverToBoxAdapter(
                child: Text('Больше нет данных'),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return SizedBox(
                height: 20.h,
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
