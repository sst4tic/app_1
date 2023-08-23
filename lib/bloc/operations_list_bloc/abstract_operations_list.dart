
import 'package:yiwucloud/models%20/operations_model.dart';

abstract class AbstractOperationsList {
  Future<OperationModel> getOperations({required int page, String? query, String? filters});
}