part of 'create_arrival_bloc.dart';

abstract class CreateArrivalEvent {}

class CheckExistenceEvent extends CreateArrivalEvent {
  final String sku;

  CheckExistenceEvent({required this.sku});
}

class AddExistArrivalEvent extends CreateArrivalEvent {
  final String sku;
  final String warehouseId;
  final String quantity;
  final int id;

  AddExistArrivalEvent({required this.sku, required this.warehouseId, required this.quantity, required this.id});
}

class AddNonExistArrivalEvent extends CreateArrivalEvent {
  final String sku;
  final String quantity;
  final String warehouseId;
  final String name;
  final String price;

  AddNonExistArrivalEvent({required this.sku, required this.warehouseId, required this.quantity, required this.name, required this.price});
}
