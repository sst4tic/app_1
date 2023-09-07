import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/models%20/plan_view_model.dart';
import 'package:http/http.dart' as http;
import '../../util/constants.dart';

part 'plan_view_event.dart';

part 'plan_view_state.dart';

class PlanViewBloc extends Bloc<PlanViewEvent, PlanViewState> {
  PlanViewBloc() : super(PlanViewInitial()) {
    Future<List<PlanViewModel>> getPlanView(String hash) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=crm_sale_plan_view&hash=$hash';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      final data = body['data'];
      return data.map<PlanViewModel>((json) => PlanViewModel.fromJson(json)).toList();

    }

    Future<TodaySalesModel> getTodaySales() async {
      var url = '${Constants.API_URL_DOMAIN}action=analytics_today_sales';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      final data = body['data'];
      return TodaySalesModel.fromJson(data);
    }

    on<LoadPlanView>((event, emit) async {
      try {
        emit(PlanViewLoading());
        var planView = await getPlanView(event.hash);
        var todaySales = await getTodaySales();
        emit(PlanViewLoaded(planView: planView, todaySales: todaySales));
      } catch (e) {
        emit(PlanViewLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
