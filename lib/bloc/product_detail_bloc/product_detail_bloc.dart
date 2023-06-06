import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models /custom_dialogs_model.dart';
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
    on<ChangeLocation>((event, emit) async {
      try {
        // ignore: use_build_context_synchronously
        showDialog(
          context: event.context,
          builder: (BuildContext context) {
            final qtyController = TextEditingController();
            qtyController.text = event.location.toString();
            return CustomAlertDialog(
                title: 'Ввести в ручную',
                content: CustomTextField(
                  controller: qtyController,
                  placeholder: 'Введите локацию',
                ),
                actions: [
                  CustomDialogAction(
                    text: 'Отмена',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CustomDialogAction(
                    text: 'Подтвердить',
                    onPressed: () async {
                      Navigator.pop(context);
                      final data = await Func().changeLocation(
                          prodId: event.productId,
                          warehouseId: event.warehouseId,
                          location: qtyController.text);
                      // ignore: use_build_context_synchronously
                      Func().showSnackbar(
                          event.context, data['message'], data['success']);
                      add(LoadProductDetail(id: event.productId.toString()));
                    },
                  ),
                ]);
          },
        );
      } catch (e) {
        emit(ProductDetailLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
