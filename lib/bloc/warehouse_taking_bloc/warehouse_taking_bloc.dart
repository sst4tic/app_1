import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/util/warehouse_sale.dart';

import '../../util/constants.dart';

part 'warehouse_taking_event.dart';

part 'warehouse_taking_state.dart';

class WarehouseTakingBloc
    extends Bloc<WarehouseTakingEvent, WarehouseTakingState> {
  WarehouseTakingBloc() : super(WarehouseTakingInitial()) {
    int page = 1;
    String query = '';
    String filters = '';

    Future loadTaking({
      String? smart,
      String? filters,
      required int page,
      required int completed,
    }) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=invoices_of_courier_list&completed=$completed&page=$page&smart=${smart ?? ''}&${filters ?? ''}';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      return body['data'];
    }

    on<LoadWarehouseTaking>((event, emit) async {
      try {
        if (state is! WarehouseTakingLoading) {
          emit(WarehouseTakingLoading());
          final body = await loadTaking(
            smart: event.query,
            filters: event.filters,
            completed: 0,
            page: page,
          );
          final bodyCompleted = await loadTaking(
            smart: event.query,
            filters: event.filters,
            completed: 1,
            page: page,
          );
          final taking = body['invoices']
              .map<Sales>((json) => Sales.fromJson(json))
              .toList();
          final completed = bodyCompleted['invoices']
              .map<Sales>((json) => Sales.fromJson(json))
              .toList();
          emit(WarehouseTakingLoaded(
              warehouseTaking: taking,
              warehouseCompleted: completed,
              totalCount: body['total'],
              totalCountCompleted: bodyCompleted['total'],
              page: 1,
              hasMore: true));
        }
      } catch (e) {
        emit(WarehouseTakingLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<LoadMore>((event, emit) async {
      try {
        if (state is WarehouseTakingLoaded && state.hasMore) {
          final warehouseAssembly =
              (state as WarehouseTakingLoaded).warehouseTaking;
          final warehouseAssemblyPostponed =
              (state as WarehouseTakingLoaded).warehouseCompleted;
          final newWarehouseAssembly = await loadTaking(
              page: state.page + 1,
              smart: query,
              filters: filters,
              completed: 0);
          warehouseAssembly.addAll(newWarehouseAssembly['invoices']
              .map<Sales>((json) => Sales.fromJson(json))
              .toList());
          final newWarehouseAssemblyPostponed = await loadTaking(
              page: state.page + 1,
              smart: query,
              filters: filters,
              completed: 1);
          warehouseAssemblyPostponed.addAll(
              newWarehouseAssemblyPostponed['invoices']
                  .map<Sales>((json) => Sales.fromJson(json))
                  .toList());
          emit(WarehouseTakingLoaded(
              warehouseTaking: warehouseAssembly,
              warehouseCompleted: warehouseAssemblyPostponed,
              hasMore:
                  newWarehouseAssembly['invoices'].length <= 10 ? false : true,
              totalCount: (state as WarehouseTakingLoaded).totalCount,
              totalCountCompleted:
                  (state as WarehouseTakingLoaded).totalCountCompleted,
              page: state.page + 1));
        }
      } catch (e) {
        emit(WarehouseTakingLoadingFailure(exception: e));
      }
    });
  }
}
