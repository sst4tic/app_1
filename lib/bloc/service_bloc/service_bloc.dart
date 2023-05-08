import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/constants.dart';
import '../../util/service.dart';

part 'service_event.dart';

part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    Future<List<Services>> loadServices() async {
      var url = '${Constants.API_URL_DOMAIN}action=products_services';
      final response = await http.get(
          Uri.parse(url),
          headers: Constants.headers()
      );
      final body = jsonDecode(response.body);
      final List<dynamic> data = body['data'];
      final services = data.map((item) => Services.fromJson(item)).toList();
      return services;
    }
    on<LoadServices>((event, emit) async {
      try {
        if (state is! ServiceLoading) {
          emit(ServiceLoading());
          var services = await loadServices();
          emit(ServiceLoaded(services: services));
        }
      } catch (e) {
        emit(ServiceLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
