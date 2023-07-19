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
          filters = event.filters ?? '';
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
              hasMore: true,
              pagePostponed: 1,
              hasMorePostponed: true));
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
          final newWarehouseAssembly = await loadAssembly(
              page: state.page + 1,
              smart: query,
              filters: filters,
              postponed: 0);
          warehouseAssembly.addAll(newWarehouseAssembly['invoices']
              .map<Sales>((json) => Sales.fromJson(json))
              .toList());
          emit(WarehouseAssemblyLoaded(
              warehouseAssembly: warehouseAssembly,
              warehouseAssemblyPostponed:
                  (state as WarehouseAssemblyLoaded).warehouseAssemblyPostponed,
              hasMore: newWarehouseAssembly['invoices'].length <= 5 &&
                      newWarehouseAssembly['invoices'].length == 0
                  ? false
                  : true,
              totalCount: (state as WarehouseAssemblyLoaded).totalCount,
              totalCountPostponed:
                  (state as WarehouseAssemblyLoaded).totalCountPostponed,
              page: state.page + 1,
              pagePostponed: (state as WarehouseAssemblyLoaded).pagePostponed,
              hasMorePostponed:
                  (state as WarehouseAssemblyLoaded).hasMorePostponed));
        }
      } catch (e) {
        emit(WarehouseAssemblyLoadingFailure(exception: e));
      }
    });
    on<LoadMorePostponed>((event, emit) async {
      try {
        if (state is WarehouseAssemblyLoaded && state.hasMorePostponed) {
          final warehouseAssembly =
              (state as WarehouseAssemblyLoaded).warehouseAssemblyPostponed;
          final newWarehouseAssembly = await loadAssembly(
              page: state.pagePostponed + 1,
              smart: query,
              filters: filters,
              postponed: 1);
          warehouseAssembly.addAll(newWarehouseAssembly['invoices']
              .map<Sales>((json) => Sales.fromJson(json))
              .toList());
          emit(WarehouseAssemblyLoaded(
              warehouseAssembly:
                  (state as WarehouseAssemblyLoaded).warehouseAssembly,
              warehouseAssemblyPostponed:
                  (state as WarehouseAssemblyLoaded).warehouseAssemblyPostponed,
              hasMore: state.hasMore,
              hasMorePostponed: newWarehouseAssembly['invoices'].length <= 5 &&
                      newWarehouseAssembly['invoices'].length == 0
                  ? false
                  : true,
              totalCount: (state as WarehouseAssemblyLoaded).totalCount,
              totalCountPostponed:
                  (state as WarehouseAssemblyLoaded).totalCountPostponed,
              page: state.page,
              pagePostponed: state.pagePostponed + 1));
        }
      } catch (e) {
        emit(WarehouseAssemblyLoadingFailure(exception: e));
      }
    });
  }
}
