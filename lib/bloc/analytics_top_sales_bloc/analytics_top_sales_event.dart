part of 'analytics_top_sales_bloc.dart';

abstract class AnalyticsTopSalesEvent {}


class LoadAnalyticsTopSales extends AnalyticsTopSalesEvent {
  LoadAnalyticsTopSales({
    this.completer,
    required this.date
  });

  final Completer? completer;
  final String date;

  List<Object?> get props => [completer];
}