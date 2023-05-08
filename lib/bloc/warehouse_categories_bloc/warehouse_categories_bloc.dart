import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/util/constants.dart';
import 'package:http/http.dart' as http;
import '../../util/categories.dart';

part 'warehouse_categories_event.dart';
part 'warehouse_categories_state.dart';

class WarehouseCategoriesBloc extends Bloc<WarehouseCategoriesEvent, WarehouseCategoriesState> {
  WarehouseCategoriesBloc() : super(WarehouseCategoriesInitial()) {
    on<LoadWarehouseCategories>((event, emit) async {
      Future<List<WarehouseCategory>> loadWarehouseCategories() async {
        var url = Uri.parse('${Constants.API_URL_DOMAIN}action=categories_list');
        final response = await http.get(
          url,
          headers: Constants.headers(),
        );
        final body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];
        final categories = data.map((item) => WarehouseCategory.fromJson(item)).toList();
        return categories;
      }
      try {
        if (state is! WarehouseCategoriesLoading) {
          emit(WarehouseCategoriesLoading());
          final categories = await loadWarehouseCategories();
          emit(WarehouseCategoriesLoaded(categories: categories));
        }
      } catch (e) {
        emit(WarehouseCategoriesError(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
