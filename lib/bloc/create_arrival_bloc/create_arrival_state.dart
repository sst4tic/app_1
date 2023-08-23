part of 'create_arrival_bloc.dart';

abstract class CreateArrivalState {}

class CreateArrivalInitial extends CreateArrivalState {}

class ArrivalExist extends CreateArrivalState {
  final ArrivalExistenceModel arrival;
  List<DropdownMenuItem<String>> warehouses;

  ArrivalExist({required this.arrival, required this.warehouses});
}

class ArrivalNotExist extends CreateArrivalState {
  final String sku;
  List<DropdownMenuItem<String>> warehouses;

  ArrivalNotExist({required this.sku, required this.warehouses});
}

class CreateArrivalError extends CreateArrivalState {
  final Object? e;

  CreateArrivalError({required this.e});
}
