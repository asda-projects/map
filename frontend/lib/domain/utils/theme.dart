import 'package:flutter/material.dart';

class AppTheme {
  // Define main colors
  static const Color primaryColor = Color(0xFFD6A49B); // Dusty Rose
  static const Color secondaryColor = Colors.black;
  static const Color accentColor = Colors.white;

  // Define a gradient for backgrounds
  static  Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFD6A49B), // Dusty Rose
      Color(0xFFD6A49B).withOpacity(0.7), // Decayed Dusty Rose
      Colors.white, // Fading to white
    ],
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
  );

  // Dark Theme (Optional)
  static ThemeData darkTheme = ThemeData(
    
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor,
      secondary: accentColor,
      surface: Colors.black,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
    ),
  );
}
