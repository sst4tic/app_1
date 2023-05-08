import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';
import '../../util/product_details.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<LoadProductDetail>((event, emit) async {
      Future<ProductDetailsWithWarehouses> loadProductDetail() async {
        var url =
            '${Constants.API_URL_DOMAIN}action=product_details&product_id=${event.id}';
        final response =
            await http.get(Uri.parse(url), headers: Constants.headers());
        final body = jsonDecode(response.body);
        final data = ProductDetails.fromJson(body['data']);
        final List<Warehouses> wareHouse = body['warehouses']
            .map<Warehouses>((json) => Warehouses.fromJson(json))
            .toList();
        return ProductDetailsWithWarehouses(
            data: data, warehouses: wareHouse);
      }
      try {
        if (state is! ProductDetailLoading) {
          emit(ProductDetailLoading());
          final productDetail = await loadProductDetail();
          emit(ProductDetailLoaded(product: productDetail));
        }
      } catch (e) {
        emit(ProductDetailLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
