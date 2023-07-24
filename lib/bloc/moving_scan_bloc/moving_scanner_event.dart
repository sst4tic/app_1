part of 'moving_scanner_bloc.dart';

abstract class MovingScannerEvent {}

class LoadScanData extends MovingScannerEvent {
  LoadScanData({
    this.completer,
    required this.id,
  });

  final Completer? completer;
  final int id;

  List<Object?> get props => [completer, id];
}

class MovingScanEvent extends MovingScannerEvent {
  MovingScanEvent({
    this.completer,
    required this.id,
    required this.context,
    required this.barcode,
  });

  final Completer? completer;
  final int id;
  final BuildContext context;
  final String barcode;

  List<Object?> get props => [completer, id, barcode];
}

class MovingInputEvent extends MovingScannerEvent {
  MovingInputEvent({
    this.completer,
    required this.id,
    required this.context,
  });

  final Completer? completer;
  final int id;
  final BuildContext context;

  List<Object?> get props => [completer, id];
}

class MovingScanQtyEvent extends MovingScannerEvent {
  MovingScanQtyEvent({
    this.completer,
    required this.id,
    required this.context,
    required this.barcode,
    required this.qty,
  });

  final Completer? completer;
  final int id;
  final BuildContext context;
  final String barcode;
  final qty;

  List<Object?> get props => [completer, id, barcode, qty];
}

class MovingScanInputQtyEvent extends MovingScannerEvent {
  MovingScanInputQtyEvent({
    this.completer,
    required this.id,
    required this.context,
    required this.barcode,
    required this.qty,
  });

  final Completer? completer;
  final int id;
  final BuildContext context;
  final String barcode;
  final qty;

  List<Object?> get props => [completer, id, barcode, qty];
}
