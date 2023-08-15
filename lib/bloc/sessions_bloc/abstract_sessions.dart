import '../../models /session_model.dart';

abstract class AbstractSessions {
  Future<Session> getSessions();
  Future destroySession(String id);
  Future destroyAllSessions({required String pass});
}