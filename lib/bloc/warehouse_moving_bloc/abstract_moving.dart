import 'package:yiwucloud/util/moving_model.dart';

abstract class AbstractMoving {
  Future<List<MovingModel>> getMoving({required int page});
}