// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Channel: ${name}";

  static String m1(amount) => "Duration: ${amount}";

  static String m2(provider) => "Login with ${provider}";

  static String m3(provider) => "Sign Up with ${provider}";

  static String m4(amount) => "${amount} Views";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "authGreetingsLogin": MessageLookupByLibrary.simpleMessage(
            "It\'s great to see you back again!"),
        "authGreetingsSignUp": MessageLookupByLibrary.simpleMessage(
            "Join us now and listen your heart beats!"),
        "channel": m0,
        "clipboardShareMusic": MessageLookupByLibrary.simpleMessage(
            "🔗 Link copied to clipboard! 🎉"),
        "downloadedMusic": MessageLookupByLibrary.simpleMessage("Downloaded"),
        "duration": m1,
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailTip":
            MessageLookupByLibrary.simpleMessage("nickname@example.com"),
        "favoriteMusic": MessageLookupByLibrary.simpleMessage("Favorite"),
        "forgotPwd": MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "hasAccount":
            MessageLookupByLibrary.simpleMessage("I already have account!"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("Enter a valid email."),
        "invalidForm": MessageLookupByLibrary.simpleMessage(
            "Form is invalid! Please check the fields."),
        "invalidFormat":
            MessageLookupByLibrary.simpleMessage("Invalid format."),
        "invalidNumber":
            MessageLookupByLibrary.simpleMessage("Enter a valid number."),
        "invalidPassword":
            MessageLookupByLibrary.simpleMessage("Invalid password."),
        "listenMusic": MessageLookupByLibrary.simpleMessage("Listen music"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginWith": m2,
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "menu": MessageLookupByLibrary.simpleMessage("Menu"),
        "noAccount":
            MessageLookupByLibrary.simpleMessage("I do not have account!"),
        "noResultsFound": MessageLookupByLibrary.simpleMessage(
            "No results found. Try a different search term."),
        "noTitle": MessageLookupByLibrary.simpleMessage("No Title"),
        "noViews": MessageLookupByLibrary.simpleMessage("No Views"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordTip": MessageLookupByLibrary.simpleMessage(
            "8+ chars, 1 uppercase, 1 lowercase, 1 number, 1 symbol (@, #, \$)."),
        "requiredField":
            MessageLookupByLibrary.simpleMessage("This field is required."),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchBarPhrase":
            MessageLookupByLibrary.simpleMessage("Search music here..."),
        "searchErrorMessage": MessageLookupByLibrary.simpleMessage(
            "An error occurred while searching. Please try again later."),
        "selectedLanguage": MessageLookupByLibrary.simpleMessage("Language"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signUpWith": m3,
        "unknowErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Please try again later."),
        "unknownChannel":
            MessageLookupByLibrary.simpleMessage("Unknown Channel"),
        "unknownDuration":
            MessageLookupByLibrary.simpleMessage("Unknown Duration"),
        "views": m4
      };
}
