import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/boilerplate/loading_screen.dart';
import 'package:frontend/presentation/screens/board/on_board.dart';
import 'package:frontend/presentation/screens/main/on_main.dart';


class AuthWrapper extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const AuthWrapper({super.key, required this.onLocaleChange});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  User? _previousUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges().distinct(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasData && snapshot.data != _previousUser) {
          _previousUser = snapshot.data;
          return OnMainScreen(onLocaleChange: widget.onLocaleChange);
        } else if (snapshot.hasError) {
          return  Center(child: Text(S.of(context).unknowErrorMessage));
        } else {
          return OnBoardScreen(onLocaleChange: widget.onLocaleChange);
        }
      },
    );
  }
}
