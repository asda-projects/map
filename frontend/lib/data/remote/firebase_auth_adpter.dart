import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:frontend/data/remote/interface_auth.dart';
import 'package:frontend/domain/services/logs.dart';

import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAdapter implements AuthInterface {
  /// Firebase and Third-Party Instances
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: dotenv.env['GOOGLE_CLIENT_ID']!,
  );
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  final AppLogger logger = AppLogger();
  
  

  /// Private Constructor for Singleton
  FirebaseAuthAdapter._internal() {
    _setPersistence(); // Configure persistence only once
    logger.debug("FirebaseAuthAdapter Initialized");
  }

  /// Singleton Instance
  static final FirebaseAuthAdapter _instance = FirebaseAuthAdapter._internal();

  /// Factory Constructor
  factory FirebaseAuthAdapter() => _instance;

  /// Configure Persistence for Web
  Future<void> _setPersistence() async {
    try {
      if (kIsWeb) {
        await _firebaseAuth.setPersistence(Persistence.LOCAL);
        logger.debug("Persistence set to LOCAL");
      }
    } catch (e) {
      logger.debug("Error setting persistence: ${e.toString()}");
    }
  }

  /// Email/Password Sign-In
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      logger.debug("Sign-In Error: ${e.toString()}");
      return null;
    }
  }

  /// Email/Password Sign-Up
  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      logger.debug("Sign-Up Error: ${e.toString()}");
      return null;
    }
  }

  /// Google Login
  @override
  Future<String?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // Canceled login

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      return _firebaseAuth.currentUser?.uid;
    } catch (e) {
      logger.debug("Google Login Error: ${e.toString()}");
      return null;
    }
  }

  /// Facebook Login
  @override
  Future<String?> loginWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login();

      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;
        if (accessToken != null) {
          final AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.tokenString);
          await _firebaseAuth.signInWithCredential(credential);
          return _firebaseAuth.currentUser?.uid;
        }
      }
      return null; // Login failed
    } catch (e) {
      logger.debug("Facebook Login Error: ${e.toString()}");
      return null;
    }
  }

  /// Logout from All Services
  @override
  Future<void> logout() async {
    try {
      // Sign out Firebase
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.signOut();
      }

      // Sign out Google
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Sign out Facebook
      final accessToken = await _facebookAuth.accessToken;
      if (accessToken != null) {
        await _facebookAuth.logOut();
      }

    } catch (e, stacktrace) {
      logger.debug("Logout Error: $e\n$stacktrace");
    }
  }
  
  @override
  User? currentUser() {
    return _firebaseAuth.currentUser;
  }
}
