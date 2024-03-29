part of 'plan_view_bloc.dart';

abstract class PlanViewState {}

class PlanViewInitial extends PlanViewState {}

class PlanViewLoading extends PlanViewState {
  PlanViewLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class PlanViewLoaded extends PlanViewState {
  PlanViewLoaded({
    required this.planView,
    required this.todaySales,
  });

  final List<PlanViewModel> planView;
  final TodaySalesModel todaySales;

  List<Object?> get props => [planView];
}

class PlanViewLoadingFailure extends PlanViewState {
  PlanViewLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}
