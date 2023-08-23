part of 'check_bloc.dart';

abstract class CheckEvent {}

class LoadCheck extends CheckEvent {
  final Completer<void>? completer;

  LoadCheck({this.completer});
}

class CheckLocationEvent extends CheckEvent {
  final Completer<void>? completer;
  final double lat;
  final double lon;
  final String type;
  final BuildContext context;

  CheckLocationEvent({this.completer, required this.lat, required this.lon,  required this.type, required this.context});
}

class LocationPostEvent extends CheckEvent {
  final Completer<void>? completer;
  final double lat;
  final double lon;
  final String type;
  final BuildContext context;

  LocationPostEvent({this.completer, required this.lat, required this.lon,  required this.type, required this.context});
}