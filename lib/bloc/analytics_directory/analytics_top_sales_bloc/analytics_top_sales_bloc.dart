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
    Future<AnalyticsTopSalesModel> getAnalytics({required String date, required int channels}) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=analytics_top_sales&date_at=$date&get_channels=$channels';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      final data = body['data'];
      final analytics = AnalyticsTopSalesModel.fromJson(data);
      return analytics;
    }

    on<LoadAnalyticsTopSales>((event, emit) async {
      try {
      if (state is! AnalyticsTopSalesLoading) {
        emit(AnalyticsTopSalesLoading());
        var analyticsChannels = await getAnalytics(date: event.date, channels: 1);
        var analyticsManagers = await getAnalytics(date: event.date, channels: 0);
        emit(AnalyticsTopSalesLoaded(channels: analyticsChannels, managers: analyticsManagers, date: event.date));
      }
      } catch (e) {
        emit(AnalyticsTopSalesLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
