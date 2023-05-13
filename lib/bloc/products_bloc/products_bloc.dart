import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/products_bloc/products_repo.dart';

import '../../util/product.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    final productsRepo = ProductsRepo();
    int pageWithFilters = 1;
    List<Product> products = [];
    on<LoadProducts>((event, emit) async {
      try {
        if (state is! ProductsLoading) {
          emit(ProductsLoading());
          products = await productsRepo.getProducts(
              page: 1,
              media: event.media,
              orderby: event.orderby,
              availability: event.availability);
          pageWithFilters = 1;
          emit(ProductsLoaded(products: products, page: 1, hasMore: true));
        }
      } catch (e) {
        emit(ProductsLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<LoadMore>((event, emit) async {
      try {
        if (state is ProductsLoaded && state.hasMore) {
          final products = (state as ProductsLoaded).products;
          final newProducts = await productsRepo.getProducts(
              page: pageWithFilters + 1,
              media: event.media,
              orderby: event.orderby,
              availability: event.availability);
          products.addAll(newProducts);
          emit(ProductsLoaded(
              products: products,
              page: pageWithFilters + 1,
              hasMore: newProducts.isNotEmpty));
          pageWithFilters += 1;
        }
      } catch (e) {
        emit(ProductsLoadingFailure(exception: e));
      }
    });
  }
}

