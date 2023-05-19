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
    Future loadTaking() async {
      var url = '${Constants.API_URL_DOMAIN}action=invoices_of_courier_list';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      return body;
    }

    on<LoadWarehouseTaking>((event, emit) async {
      try {
        if (state is! WarehouseTakingLoading) {
          emit(WarehouseTakingLoading());
          final body = await loadTaking();
          final taking =
              body['data'].map<Sales>((json) => Sales.fromJson(json)).toList();
          final completed = body['data_completed']
              .map<Sales>((json) => Sales.fromJson(json))
              .toList();
          emit(WarehouseTakingLoaded(
              warehouseTaking: taking, warehouseCompleted: completed));
        }
      } catch (e) {
        emit(WarehouseTakingLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
