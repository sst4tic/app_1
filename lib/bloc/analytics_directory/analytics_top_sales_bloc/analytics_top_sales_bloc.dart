import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/util/analytics_top_sales_model.dart';
import '../../../util/constants.dart';
import 'package:http/http.dart' as http;

part 'analytics_top_sales_event.dart';

part 'analytics_top_sales_state.dart';

class AnalyticsTopSalesBloc
    extends Bloc<AnalyticsTopSalesEvent, AnalyticsTopSalesState> {
  AnalyticsTopSalesBloc() : super(AnalyticsTopSalesInitial()) {
    Future<AnalyticsTopSalesModel> getAnalytics({required String date}) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=analytics_top_sales&date_at=$date';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      print(body);
      final data = body['data'];
      final analytics = AnalyticsTopSalesModel.fromJson(data);
      return analytics;
    }

    on<LoadAnalyticsTopSales>((event, emit) async {
      if (state is! AnalyticsTopSalesLoading) {
        emit(AnalyticsTopSalesLoading());
        var analytics = await getAnalytics(date: event.date);
        emit(AnalyticsTopSalesLoaded(analytics: analytics, date: event.date));
      }
    });
  }
}
