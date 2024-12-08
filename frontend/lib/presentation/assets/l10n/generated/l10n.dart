// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Language`
  String get selectedLanguage {
    return Intl.message(
      'Language',
      name: 'selectedLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login with {provider}`
  String loginWith(Object provider) {
    return Intl.message(
      'Login with $provider',
      name: 'loginWith',
      desc: '',
      args: [provider],
    );
  }

  /// `Listen music`
  String get listenMusic {
    return Intl.message(
      'Listen music',
      name: 'listenMusic',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up with {provider}`
  String signUpWith(Object provider) {
    return Intl.message(
      'Sign Up with $provider',
      name: 'signUpWith',
      desc: '',
      args: [provider],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `nickname@example.com`
  String get emailTip {
    return Intl.message(
      'nickname@example.com',
      name: 'emailTip',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `8+ chars, 1 uppercase, 1 lowercase, 1 number, 1 symbol (@, #, $).`
  String get passwordTip {
    return Intl.message(
      '8+ chars, 1 uppercase, 1 lowercase, 1 number, 1 symbol (@, #, \$).',
      name: 'passwordTip',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPwd {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPwd',
      desc: '',
      args: [],
    );
  }

  /// `I do not have account!`
  String get noAccount {
    return Intl.message(
      'I do not have account!',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `I already have account!`
  String get hasAccount {
    return Intl.message(
      'I already have account!',
      name: 'hasAccount',
      desc: '',
      args: [],
    );
  }

  /// `This field is required.`
  String get requiredField {
    return Intl.message(
      'This field is required.',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email.`
  String get invalidEmail {
    return Intl.message(
      'Enter a valid email.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password.`
  String get invalidPassword {
    return Intl.message(
      'Invalid password.',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid format.`
  String get invalidFormat {
    return Intl.message(
      'Invalid format.',
      name: 'invalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid number.`
  String get invalidNumber {
    return Intl.message(
      'Enter a valid number.',
      name: 'invalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Form is invalid! Please check the fields.`
  String get invalidForm {
    return Intl.message(
      'Form is invalid! Please check the fields.',
      name: 'invalidForm',
      desc: '',
      args: [],
    );
  }

  /// `It's great to see you back again!`
  String get authGreetingsLogin {
    return Intl.message(
      'It\'s great to see you back again!',
      name: 'authGreetingsLogin',
      desc: '',
      args: [],
    );
  }

  /// `Join us now and listen your heart beats!`
  String get authGreetingsSignUp {
    return Intl.message(
      'Join us now and listen your heart beats!',
      name: 'authGreetingsSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Search music here...`
  String get searchBarPhrase {
    return Intl.message(
      'Search music here...',
      name: 'searchBarPhrase',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Downloaded`
  String get downloadedMusic {
    return Intl.message(
      'Downloaded',
      name: 'downloadedMusic',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favoriteMusic {
    return Intl.message(
      'Favorite',
      name: 'favoriteMusic',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'th'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
