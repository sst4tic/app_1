import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../models /custom_dialogs_model.dart';
import '../../util/function_class.dart';
import '../../util/product_details.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    String val = '0';
    on<LoadProductDetail>((event, emit) async {
      try {
        if (state is! ProductDetailLoading) {
          emit(ProductDetailLoading());
          final productDetail = await Func().loadProductDetail(event.id);
          final warehouses = await Func().loadWarehousesList();
          final List<DropdownMenuItem<String>> mappedWarehouses = warehouses
              .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                  value: e['id'].toString(), child: Text(e['name_lang']!)))
              .toList();
          emit(ProductDetailLoaded(
              product: productDetail,
              warehouses: mappedWarehouses,
              value: val));
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
    on<ChangeWarehouseInSale>((event, emit) async {
      try {
        event.context.loaderOverlay.show();
        final loadedState = (state as ProductDetailLoaded);
        final inSale = await Func()
            .getInSale(prodId: event.productId, warehouseId: event.warehouseId);
        val = event.warehouseId.toString();
        emit(ProductDetailLoaded(
          value: val,
            product: ProductDetailsWithWarehouses(
                data: ProductDetails(
                  id: loadedState.product.data.id,
                  name: loadedState.product.data.name,
                  sku: loadedState.product.data.sku,
                  createdAt: loadedState.product.data.createdAt ?? '',
                  media: loadedState.product.data.media,
                  price: loadedState.product.data.price,
                  editPermission: loadedState.product.data.editPermission,
                  totalCount: loadedState.product.data.totalCount,
                  description: loadedState.product.data.description,
                  availability: loadedState.product.data.availability,
                  preorders: loadedState.product.data.preorders,
                  inSale: inSale,
                ),
                warehouses: loadedState.product.warehouses),
            warehouses: loadedState.warehouses));
        event.context.loaderOverlay.hide();
      } catch (e) {
        emit(ProductDetailLoadingFailure(exception: e));
        event.context.loaderOverlay.hide();
      } finally {
        event.completer?.complete();
      }
    });
  }
}
