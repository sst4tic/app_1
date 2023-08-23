
import '../../util/arrival_existence_model.dart';

abstract class AbstractCreateArrival {
  Future<ArrivalExistenceModel> checkArrivalExistence({required String sku});
  Future addExistArrival({required sku, required warehouseId, required quantity, required id});
  Future addNonExistArrival({required sku, required warehouseId, required quantity, required name, required price});
  }