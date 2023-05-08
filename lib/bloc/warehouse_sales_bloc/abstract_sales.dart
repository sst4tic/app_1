import 'package:yiwucloud/util/warehouse_sale.dart';

abstract class AbstractSales {
  Future<List<WarehouseSalesModel>> getSales({required int page});
}