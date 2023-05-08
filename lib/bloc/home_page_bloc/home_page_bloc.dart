import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/util/service.dart';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    Future<List<Services>> loadServices() async {
      var url = '${Constants.API_URL_DOMAIN}action=user_services';
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
        if (state is! HomePageLoading) {
          emit(HomePageLoading());
          var services = await loadServices();
          emit(HomePageLoaded(services: services));
        }
      } catch (e) {
        emit(HomePageLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
