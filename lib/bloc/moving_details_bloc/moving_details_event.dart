part of 'moving_details_bloc.dart';

abstract class MovingDetailsEvent {}

class LoadMovingDetails extends MovingDetailsEvent {
  LoadMovingDetails({
    this.completer,
    required this.id,
  });

  final int id;
  final Completer? completer;

  List<Object?> get props => [id, completer];
}

class MovingRedirectionEvent extends MovingDetailsEvent {
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

class DefineCourierEvent extends MovingDetailsEvent {
  DefineCourierEvent({
    required this.context,
    required this.courierId,
    required this.invoiceId
  });

  final BuildContext context;
  final int courierId;
  final int invoiceId;

  List<Object?> get props => [context, courierId, invoiceId];
}

class ChangeBoxQty extends MovingDetailsEvent {
  ChangeBoxQty({
    required this.id,
    required this.context,
    this.select,
  });

  final int id;
  final BuildContext context;
  final BtnBoxesSelectStatus? select;

  List<Object?> get props => [id, context];
}
