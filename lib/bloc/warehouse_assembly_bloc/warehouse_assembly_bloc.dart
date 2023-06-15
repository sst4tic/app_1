import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/constants.dart';
import '../../util/warehouse_sale.dart';

part 'warehouse_assembly_event.dart';

part 'warehouse_assembly_state.dart';

class WarehouseAssemblyBloc
    extends Bloc<WarehouseAssemblyEvent, WarehouseAssemblyState> {
  WarehouseAssemblyBloc() : super(WarehouseAssemblyInitial()) {
    int page = 1;
    String query = '';
    String filters = '';

    Future loadAssembly({
      String? smart,
      String? filters,
      required int page,
      required int postponed,
    }) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=invoices_of_assembler_list&postponed=$postponed&page=$page&smart=${smart ?? ''}&${filters ?? ''}';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      return body['data'];
    }

    on<LoadWarehouseAssembly>((event, emit) async {
      try {
        if (state is! WarehouseAssemblyLoading) {
          emit(WarehouseAssemblyLoading());
          final resp = await loadAssembly(
              postponed: 0,
              smart: event.query,
              filters: event.filters,
              page: page);
          final respPostponed = await loadAssembly(
              postponed: 1,
              smart: event.query,
              filters: event.filters,
              page: page);
          final warehouseAssemblyPostponed = respPostponed['invoices']
              .map<Sales>((json) => Sales.fromJson(json))
              .toList();
          final warehouseAssembly = resp['invoices']
              .map<Sales>((json) => Sales.fromJson(json))
              .toList();
          final total = resp['total'];
          emit(WarehouseAssemblyLoaded(
              warehouseAssembly: warehouseAssembly,
              warehouseAssemblyPostponed: warehouseAssemblyPostponed,
              totalCount: total,
              totalCountPostponed: respPostponed['total'],
              page: 1,
              hasMore: true));
        }
      } catch (e) {
        emit(WarehouseAssemblyLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<LoadMore>((event, emit) async {
      try {
        if (state is WarehouseAssemblyLoaded && state.hasMore) {
          final warehouseAssembly =
              (state as WarehouseAssemblyLoaded).warehouseAssembly;
          final warehouseAssemblyPostponed =
              (state as WarehouseAssemblyLoaded).warehouseAssemblyPostponed;
          final newWarehouseAssembly = await loadAssembly(
              page: state.page + 1,
              smart: query,
              filters: filters,
              postponed: 0);
          warehouseAssembly.addAll(newWarehouseAssembly['invoices']
              .map<Sales>((json) => Sales.fromJson(json))
              .toList());
          final newWarehouseAssemblyPostponed = await loadAssembly(
              page: state.page + 1,
              smart: query,
              filters: filters,
              postponed: 1);
          warehouseAssemblyPostponed.addAll(
              newWarehouseAssemblyPostponed['invoices']
                  .map<Sales>((json) => Sales.fromJson(json))
                  .toList());
          emit(WarehouseAssemblyLoaded(
              warehouseAssembly: warehouseAssembly,
              warehouseAssemblyPostponed: warehouseAssemblyPostponed,
              hasMore:
                  newWarehouseAssembly['invoices'].length <= 10 ? false : true,
              totalCount: (state as WarehouseAssemblyLoaded).totalCount,
              totalCountPostponed:
                  (state as WarehouseAssemblyLoaded).totalCountPostponed,
              page: state.page + 1));
        }
      } catch (e) {
        emit(WarehouseAssemblyLoadingFailure(exception: e));
      }
    });
  }
}
