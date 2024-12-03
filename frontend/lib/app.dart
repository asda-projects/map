

import 'package:flutter/material.dart';
import 'package:frontend/domain/utils/theme.dart';
import 'package:frontend/presentation/screens/board/on_board.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme, // Apply the light theme
        darkTheme: AppTheme.darkTheme, // Apply the dark theme (optional)
        title: 'HeartBeats',
        home: OnBoardScreen()
      
    );
  }
}
