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
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          backgroundColor: Colors.white, // Prevent white screen
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        );
      } else if (snapshot.hasData) {
        return OnSearchScreen(onLocaleChange: onLocaleChange);
      } else {
        return OnBoardScreen(onLocaleChange: onLocaleChange);
      }
    },
  );
}
}