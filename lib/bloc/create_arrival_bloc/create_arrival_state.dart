part of 'create_arrival_bloc.dart';

abstract class CreateArrivalState {}

class CreateArrivalInitial extends CreateArrivalState {}

class ArrivalExist extends CreateArrivalState {
  final ArrivalExistenceModel arrival;

  ArrivalExist({required this.arrival});
}

class ArrivalNotExist extends CreateArrivalState {
  final String sku;

  ArrivalNotExist({required this.sku});
}

