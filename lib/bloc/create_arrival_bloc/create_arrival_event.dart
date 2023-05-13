part of 'create_arrival_bloc.dart';

abstract class CreateArrivalEvent {}

class CheckExistenceEvent extends CreateArrivalEvent {
  final String sku;

  CheckExistenceEvent({required this.sku});

}
