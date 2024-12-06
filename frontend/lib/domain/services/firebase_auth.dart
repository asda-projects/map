

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:frontend/data/remote/contracts.dart';
import 'package:frontend/domain/services/logs.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthContract {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId:  dotenv.env['GOOGLE_CLIENT_ID']!);
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  final AppLogger logger = AppLogger();

  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
   
      try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    
    return userCredential;
      } catch (e) {
       logger .debug(e.toString());
       return null;
      }

  }
  
  Future<String?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid; // Return the new user's UID
    } catch (e) {
       logger .debug(e.toString());
       return null;
      }
  }

  @override
  Future<String?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the login
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      return _firebaseAuth.currentUser?.uid; // Return user ID
    } catch (e) {
       logger .debug(e.toString());
       return null;
      }
  }

  @override
  Future<String?> loginWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login();
      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;
        if (accessToken != null) {
          final AuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);
          await _firebaseAuth.signInWithCredential(credential);
          return _firebaseAuth.currentUser?.uid; // Return user ID
        }
      }
      return null; // Login failed
    } catch (e) {
       logger .debug(e.toString());
       return null;
      }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();

  }
}