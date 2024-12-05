abstract class AuthContract {
  Future<String?> loginWithGoogle();
  Future<String?> loginWithFacebook();
  Future<void> logout();
}


