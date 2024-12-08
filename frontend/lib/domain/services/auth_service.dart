import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/data/remote/firebase_auth_adpter.dart';
import 'package:frontend/domain/services/logs.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';

class AuthService {
  final GlobalKey<FormState> formKey;
  final Function onLocaleChange;
  final Function navigateToMainScreen;
  final Function(bool) setLoading;

  FirebaseAuthAdapter firebaseAuth = FirebaseAuthAdapter();

  AppLogger logger = AppLogger();

  AuthService({
    required this.formKey,
    required this.onLocaleChange,
    required this.navigateToMainScreen,
    required this.setLoading,
  });

  /// Login using a third-party provider
  Future<void> loginWithProvider(String provider) async {
    if (provider.toLowerCase() == "google") {
      await firebaseAuth.loginWithGoogle();
    } else if (provider.toLowerCase() == "facebook") {
      await firebaseAuth.loginWithFacebook();
    }
  }

  /// Submit the form for sign-in or sign-up
  Future<void> submitForm({
    required BuildContext context,
    required String email,
    required String password,
    required bool isSignUp,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      setLoading(true);  // Start loading

      try {
        UserCredential? userCredential;

        if (!isSignUp) {

          
          userCredential = await firebaseAuth.signIn(
            email: email,
            password: password,
          );

          
        } else {
          userCredential = await firebaseAuth.signUp(
            email: email,
            password: password,
          );
        }

        if (userCredential != null) {
          
          await Future.delayed(const Duration(seconds: 2));
          setLoading(false);  // Stop loading
          
          if (context.mounted) {
            navigateToMainScreen(
              context,
              'OnMainScreen',
              arguments: {'onLocaleChange': onLocaleChange},
            );
          }
        } else {
         if (context.mounted)  _handleAuthFailure(context, S.of(context).unknowErrorMessage);
        }


      } catch (e) {
        if (context.mounted) _handleAuthFailure(context, S.of(context).unknowErrorMessage);
      }
    } else {
      _showSnackBar(context, S.of(context).invalidForm);
    }
  }

  /// Handle authentication failure
  void _handleAuthFailure(BuildContext context, String message) async {
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);  // Stop loading

    if (context.mounted) {
      _showSnackBar(context, message);
    }
  }

  /// Display a snack bar message
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
