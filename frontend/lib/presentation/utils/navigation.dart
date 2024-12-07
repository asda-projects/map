import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/auth/on_auth.dart';
import 'package:frontend/presentation/screens/search/on_search.dart';

class AppNavigation {
  // Define a method to store page mappings with builders
  static Widget? getPage(String pageName, {Map<String, dynamic>? arguments}) {
    final pages = {
      "OnAuthScreen": () => OnAuthScreen(
            onLocaleChange: arguments?['onLocaleChange'], // Pass specific argument
          ),
        "OnSearchScreen": () => OnSearchScreen(
            onLocaleChange: arguments?['onLocaleChange'], // Pass specific argument
          ),
    };

    return pages[pageName]?.call();
  }

  // Static method to navigate to a page
  static void navigateToPage(BuildContext context, String pageName, {Map<String, dynamic>? arguments}) {
    final page = getPage(pageName, arguments: arguments);
    if (page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    } else {
      // Optional: Handle the case when the page is not found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Page redirection error!')),
      );
    }
  }
}