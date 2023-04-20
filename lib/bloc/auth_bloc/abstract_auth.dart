
abstract class AbstractAuth {
  getToken();
  Future login(String email, String password, context);
}