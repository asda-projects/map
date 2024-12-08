import 'package:flutter/material.dart';

abstract class AuthInterface {
  Future<String?> loginWithGoogle();
  Future<String?> loginWithFacebook();
  Future<void> logout();
}


