part of 'sales_details_bloc.dart';

abstract class SalesDetailsEvent {}

class LoadSalesDetails extends SalesDetailsEvent {
  LoadSalesDetails({
    this.completer,
    required this.id,
  });

  final int id;
  final Completer? completer;

  List<Object?> get props => [id, completer];
}

class MovingRedirectionEvent extends SalesDetailsEvent {
  MovingRedirectionEvent({
    required this.context,
    required this.id,
    required this.act,
  });

  final int id;
  final String act;
  final BuildContext context;

  List<Object?> get props => [id, act];
}

class ChangeBoxQty extends SalesDetailsEvent {
  ChangeBoxQty({
    required this.id,
    required this.context,
  });

  final int id;
  final BuildContext context;

  List<Object?> get props => [id, context];
}