
abstract class AbstractAuth {
  getToken();
  Future<void> getFirebaseToken(val);
  Future login(String email, String password, context);
}