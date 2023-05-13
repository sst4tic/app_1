import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/function_class.dart';
import '../../util/product_details.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<LoadProductDetail>((event, emit) async {
      try {
        if (state is! ProductDetailLoading) {
          emit(ProductDetailLoading());
          final productDetail = await Func().loadProductDetail(event.id);
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
