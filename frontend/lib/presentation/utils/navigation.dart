import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/presentation/screens/auth/on_auth.dart';
import 'package:frontend/presentation/screens/main/on_main.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';


class AppNavigation {
  /// Retrieve Page Widgets by Name
  static Widget? getPage(String pageName, {Map<String, dynamic>? arguments}) {
    final pages = {
      "OnAuthScreen": () => OnAuthScreen(
            onLocaleChange: arguments?['onLocaleChange'],
          ),
      "OnMainScreen": () => OnMainScreen(
            onLocaleChange: arguments?['onLocaleChange'],
          ),
    };

    return pages[pageName]?.call();
  }

  /// Navigate to a Specific Page
  static void navigateToPage(
    BuildContext context,
    String pageName, {
    Map<String, dynamic>? arguments,
  }) {
    final page = getPage(pageName, arguments: arguments);
    if (page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    } else {
      _showError(context, S.of(context).unknowErrorMessage);
    }
  }

  /// Refresh the App Like F5
  static void refreshApp(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => App()),
      (Route<dynamic> route) => false,
    );
  }

  /// Show a Snackbar for Errors
  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
