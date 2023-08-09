part of 'analytics_top_sales_bloc.dart';

abstract class AnalyticsTopSalesState {}

class AnalyticsTopSalesInitial extends AnalyticsTopSalesState {}

class AnalyticsTopSalesLoading extends AnalyticsTopSalesState {
  AnalyticsTopSalesLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class AnalyticsTopSalesLoaded extends AnalyticsTopSalesState {
  AnalyticsTopSalesLoaded({
    required this.channels,
    required this.managers,
    required this.date,
  });

  final AnalyticsTopSalesModel? channels;
  final AnalyticsTopSalesModel? managers;
  final String date;

  List<Object?> get props => [channels, managers];
}

class AnalyticsTopSalesLoadingFailure extends AnalyticsTopSalesState {
  AnalyticsTopSalesLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}

