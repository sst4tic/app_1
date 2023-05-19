import '../../util/sales_details_model.dart';

abstract class AbstractSalesDetails {
  Future<SalesDetailsModel> loadSalesDetails({required int id});
  Future movingRedirection({required int id, required String act});
  Future changeBoxQty({required int id, required boxQty});
}