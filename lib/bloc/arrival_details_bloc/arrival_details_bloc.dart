import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models /arrival_details_model.dart';
import '../../util/constants.dart';
part 'arrival_details_event.dart';
part 'arrival_details_state.dart';

class ArrivalDetailsBloc extends Bloc<ArrivalDetailsEvent, ArrivalDetailsState> {
  ArrivalDetailsBloc() : super(ArrivalDetailsInitial()) {
    Future<ArrivalDetailsModel> getDetails({required id}) async {
      var url = '${Constants.API_URL_DOMAIN}id=$id&action=arrival_details';
      final response = await http.get(
          Uri.parse(url),
          headers: Constants.headers()
      );
      final body = jsonDecode(response.body);
      final data = body['data'];
      final arrival = ArrivalDetailsModel.fromJson(data);
      return arrival;
    }

    on<LoadArrivalDetails>((event, emit) async {
      try {
        emit(ArrivalDetailsLoading());
        var details = await getDetails(id: event.id);
        emit(ArrivalDetailsLoaded(
            arrivalDetails: details));
      } catch (e) {
        emit(ArrivalDetailsError(e: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
