part of 'plan_view_bloc.dart';

abstract class PlanViewEvent {}

class LoadPlanView extends PlanViewEvent {
  LoadPlanView({
    this.completer,
    required this.hash
  });

  final Completer? completer;
  final String hash;


  List<Object?> get props => [completer];
}
