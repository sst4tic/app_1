import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/warehouse_sales_bloc/warehouse_sales_repo.dart';
import 'package:yiwucloud/util/warehouse_sale.dart';

part 'warehouse_sales_event.dart';
part 'warehouse_sales_state.dart';

class WarehouseSalesBloc extends Bloc<WarehouseSalesEvent, WarehouseSalesState> {
  WarehouseSalesBloc() : super(WarehouseSalesInitial()) {
    final salesRepo = SalesRepo();
    int page = 1;
    WarehouseSalesModel warehouseSales = WarehouseSalesModel(btnPermission: false, sales: []);
    on<LoadWarehouseSales>((event, emit) async {
      try {
        if (state is! WarehouseSalesLoading) {
          emit(WarehouseSalesLoading());
          warehouseSales = await salesRepo.getSales(page: page);
          emit(WarehouseSalesLoaded(
              warehouseSales: warehouseSales, page: 1, hasMore: true));
        }
      } catch (e) {
        emit(WarehouseSalesLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<LoadMore>((event, emit) async {
      try {
        if (state is WarehouseSalesLoaded && state.hasMore) {
          final warehouseSales = (state as WarehouseSalesLoaded).warehouseSales;
          final newWarehouseSales =
             await salesRepo.getSales(page: state.page + 1);
          warehouseSales.sales.addAll(newWarehouseSales.sales);
          emit(WarehouseSalesLoaded(
              warehouseSales: warehouseSales,
              page: state.page + 1,
              hasMore: newWarehouseSales.sales.isNotEmpty));
        }
      } catch (e) {
        emit(WarehouseSalesLoadingFailure(exception: e));
      }
    });
  }
}
