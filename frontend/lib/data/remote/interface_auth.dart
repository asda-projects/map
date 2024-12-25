import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthInterface {
  Future<String?> loginWithGoogle();
  Future<String?> loginWithFacebook();
  Future<void> logout();
  User? currentUser();
}


