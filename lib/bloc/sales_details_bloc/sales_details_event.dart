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

class PostponeEvent extends SalesDetailsEvent {
  PostponeEvent({
    required this.id,
    required this.context,
    this.reasonId
  });

  final int id;
  final BuildContext context;
  final int? reasonId;
  List<Object?> get props => [id, context];
}

class PostponeSendEvent extends SalesDetailsEvent {
  PostponeSendEvent({
    required this.id,
    required this.context,
    required this.reasonId,
  });

  final int id;
  final BuildContext context;
  final int reasonId;

  List<Object?> get props => [id, context, reasonId];
}

class DefineCourierEvent extends SalesDetailsEvent {
  DefineCourierEvent({
    required this.context,
    required this.courierId,
    required this.invoiceId
  });

  final BuildContext context;
  final int courierId;
  final int invoiceId;

  List<Object?> get props => [ context, courierId, invoiceId];
}