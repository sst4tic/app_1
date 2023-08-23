import '../../models /workpace_model.dart';

abstract class AbstractCheck {
  Future<WorkpaceModel> loadCheck();
  Future workpacePostpone({required String lat, required String lon, required String type});
  Future locationPost({required String lat, required String lon, required String type});

}