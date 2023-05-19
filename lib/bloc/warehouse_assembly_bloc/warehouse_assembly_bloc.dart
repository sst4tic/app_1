import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/constants.dart';
import '../../util/warehouse_sale.dart';

part 'warehouse_assembly_event.dart';
part 'warehouse_assembly_state.dart';

class WarehouseAssemblyBloc extends Bloc<WarehouseAssemblyEvent, WarehouseAssemblyState> {
  WarehouseAssemblyBloc() : super(WarehouseAssemblyInitial()) {
    Future<List<Sales>> loadAssembly() async {
      var url = '${Constants.API_URL_DOMAIN}action=invoices_of_assembler_list';
      final response =
      await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      return body['data'].map<Sales>((json) => Sales.fromJson(json)).toList();
    }
    on<LoadWarehouseAssembly>((event, emit) async {
      try {
      if(state is! WarehouseAssemblyLoading) {
        emit(WarehouseAssemblyLoading());
        final warehouseAssembly = await loadAssembly();
        emit(WarehouseAssemblyLoaded(warehouseAssembly: warehouseAssembly));
      }
      } catch (e) {
        emit(WarehouseAssemblyLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
