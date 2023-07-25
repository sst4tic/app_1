import '../../models /moving_details.dart';

abstract class AbstractMovingDetails {
  Future<MovingDetailsModel> loadMovingDetails({required int id});
  Future movingRedirection({required int id, required String act});
  Future defineCourier({required int movingId, required int courierId});
  Future changeBoxQty({required int id, required qty});
}