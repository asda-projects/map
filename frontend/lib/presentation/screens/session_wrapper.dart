import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/boilerplate/loading_screen.dart';
import 'package:frontend/presentation/screens/board/on_board.dart';
import 'package:frontend/presentation/screens/main/on_main.dart';


class AuthWrapper extends StatelessWidget {

  final Function(Locale) onLocaleChange;

  const AuthWrapper({super.key, required this.onLocaleChange});
  

  @override
Widget build(BuildContext context) {
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const LoadingScreen(); // Use loading widget
      } else if (snapshot.hasData) {
        return OnMainScreen(onLocaleChange: onLocaleChange);
      } else {
        return OnBoardScreen(onLocaleChange: onLocaleChange);
      }
    },
  );
}
}