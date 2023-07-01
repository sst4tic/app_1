part of 'check_bloc.dart';

abstract class CheckEvent {}

class LoadCheck extends CheckEvent {
  final Completer<void>? completer;

  LoadCheck({this.completer});
}

class ComingEvent extends CheckEvent {
  final Completer<void>? completer;

  ComingEvent({this.completer});
}

class LeftEvent extends CheckEvent {
  final Completer<void>? completer;

  LeftEvent({this.completer});
}

class CheckInEvent extends CheckEvent {
  final Completer<void>? completer;
  final double lat;
  final double lon;
  final BuildContext context;

  CheckInEvent({this.completer, required this.lat, required this.lon, required this.context});
}

class CheckOutEvent extends CheckEvent {
  final Completer<void>? completer;
  final double lat;
  final double lon;
  final BuildContext context;

  CheckOutEvent({this.completer, required this.lat, required this.lon, required this.context});
}