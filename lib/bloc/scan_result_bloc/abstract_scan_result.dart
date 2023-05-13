import 'package:yiwucloud/bloc/scan_result_bloc/scan_result_repo.dart';

abstract class AbstractScanResult {
  Future<ResultModel> getScanResult(code);
}