import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/board/on_board.dart';
import 'package:frontend/presentation/screens/search/on_search.dart';

class AuthWrapper extends StatelessWidget {

  final Function(Locale) onLocaleChange;

  const AuthWrapper({super.key, required this.onLocaleChange});
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Check if the user is logged in
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            color: Colors.black,
          ));
        } else if (snapshot.hasData) {
          return OnSearchScreen(onLocaleChange: onLocaleChange); // Redirect to Dashboard if logged in
        } else {
          return OnBoardScreen(onLocaleChange: onLocaleChange); // Redirect to Onboarding if not logged in
        }
      },
    );
  }
}