

import 'package:flutter/material.dart';


import 'package:frontend/presentation/screens/auth/small_widget_auth.dart';
import 'package:frontend/presentation/screens/auth/wide_widget_auth.dart';
import 'package:frontend/presentation/utils/screen_adjuster.dart';

class OnLoginScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const OnLoginScreen({
    super.key, 
    required this.onLocaleChange
    });

  @override
  OnLoginScreenState createState() => OnLoginScreenState();
}

class OnLoginScreenState extends State<OnLoginScreen>  {

  @override
  Widget build(BuildContext context) {

    final adjuster = ScreenAdjuster<Widget>(
      smallWidget: SmallWidgetAuth(onLocaleChange: widget.onLocaleChange),
      wideWidget: const WideWidgetAuth(),
      threshold: 800, // Customize threshold for responsiveness
    );
    
    return adjuster.adjust(context);

  }

}