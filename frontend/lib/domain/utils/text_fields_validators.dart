import 'package:flutter/material.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';

class FieldValidator {
  /// Validates that the field is not empty
  static String? required(BuildContext context, String? value) {
    String message = S.of(context).requiredField;

    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// Validates an email address
  static String? email(BuildContext context, String? value ) {
    String message = S.of(context).invalidEmail;

    if (value == null || value.trim().isEmpty) {
      return S.of(context).requiredField;
    }
    const emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(emailPattern).hasMatch(value)) {
      return message;
    }
    return null;
  }

 
  static String? password(BuildContext context, String? value) {
    String message = S.of(context).invalidPassword;
    
    if (value == null || value.trim().isEmpty) {
      return S.of(context).requiredField;
    }
    const passwordPattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=]).{8,}$';
    if (!RegExp(passwordPattern).hasMatch(value)) {
      return "$message ${S.of(context).passwordTip}";
    }
    return null;
  }

  /// Validates a field with a custom RegEx
  static String? custom(BuildContext context, String? value, String pattern) {
    String message = S.of(context).requiredField;

    if (value == null || value.trim().isEmpty) {
      return S.of(context).requiredField;
    }
    if (!RegExp(pattern).hasMatch(value)) {
      return message;
    }
    return null;
  }

  /// Validates a numeric field
  static String? numeric(BuildContext context, String? value) {
    String message = S.of(context).invalidNumber;
    
    if (value == null || value.trim().isEmpty) {
      return S.of(context).requiredField;
    }
    if (double.tryParse(value) == null) {
      return message;
    }
    return null;
  }
}
