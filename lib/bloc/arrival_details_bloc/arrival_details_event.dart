part of 'arrival_details_bloc.dart';

abstract class ArrivalDetailsEvent {}

class LoadArrivalDetails extends ArrivalDetailsEvent {
   LoadArrivalDetails({
    this.completer,
    required this.id,
  });

  final Completer? completer;
  final String id;
}