import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../util/arrival_existence_model.dart';
import '../../util/constants.dart';

part 'create_arrival_event.dart';
part 'create_arrival_state.dart';

class CreateArrivalBloc extends Bloc<CreateArrivalEvent, CreateArrivalState> {
  // TODO: make it later :)
  CreateArrivalBloc() : super(CreateArrivalInitial()) {
    Future checkArrivalExistence({required String sku}) async {
      var url = '${Constants.API_URL_DOMAIN}action=arrival_exist&sku=$sku';
      final response = await http.get(
          Uri.parse(url),
          headers: Constants.headers()
      );
      final body = jsonDecode(response.body);
      final data = body['data'];
      final arrival = ArrivalExistenceModel.fromJson(data);
      return arrival;
    }
    // on<CheckExistenceEvent>((event, emit) async {
    //   try {
    //     if (state is! ArrivalExist) {
    //       final arrival = await checkArrivalExistence(sku: event.sku);
    //       emit(ArrivalExist(arrival: arrival));
    //     }
    //   } catch(e) {
    //     emit(ArrivalNotExist(sku: event.sku));
    //   } finally {
    //     event.completer?.complete();
    //   }
    // });
  }
}
