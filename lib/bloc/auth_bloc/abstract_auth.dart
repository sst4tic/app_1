
abstract class AbstractAuth {
  getToken();
  getFirebaseToken();
  Future login(String email, String password, context);
}