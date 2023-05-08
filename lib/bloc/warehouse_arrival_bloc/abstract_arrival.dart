import 'package:yiwucloud/util/arrival_model.dart';

abstract class AbstractArrival {
  Future<List<ArrivalModel>> getArrival({required int page});
}