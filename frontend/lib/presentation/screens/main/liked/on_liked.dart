

import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/main/liked/small_widget_liked.dart';
import 'package:frontend/presentation/screens/main/liked/wide_widget_liked.dart';


import 'package:frontend/presentation/utils/screen_adjuster.dart';

class OnLikedScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const OnLikedScreen({
    super.key, 
    required this.onLocaleChange
    });

  @override
  OnLikedScreenState createState() => OnLikedScreenState();
}

class OnLikedScreenState extends State<OnLikedScreen>  {

  @override
  Widget build(BuildContext context) {

    final adjuster = ScreenAdjuster<Widget>(
      smallWidget: SmallWidgetLiked(onLocaleChange: widget.onLocaleChange),
      wideWidget: const WideWidgetLiked(),
      threshold: 800, // Customize threshold for responsiveness
    );
    
    return adjuster.adjust(context);

  }

}