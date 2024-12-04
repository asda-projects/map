

import 'package:flutter/material.dart';
import 'package:frontend/domain/utils/theme.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:frontend/presentation/screens/board/on_board.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Locale? _locale;

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    

    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme, // Apply the light theme
        darkTheme: AppTheme.darkTheme, // Apply the dark theme (optional)
        title: 'HeartBeats',
         locale: _locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
        home: OnBoardScreen(onLocaleChange: _changeLanguage)
      
    );
  }
}
