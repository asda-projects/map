

import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/main/search/small_widget_search.dart';
import 'package:frontend/presentation/screens/main/search/wide_widget_search.dart';

import 'package:frontend/presentation/utils/screen_adjuster.dart';

class OnSearchScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const OnSearchScreen({
    super.key, 
    required this.onLocaleChange
    });

  @override
  OnSearchScreenState createState() => OnSearchScreenState();
}

class OnSearchScreenState extends State<OnSearchScreen>  {

  @override
  Widget build(BuildContext context) {

    final adjuster = ScreenAdjuster<Widget>(
      smallWidget: SmallWidgetSearch(onLocaleChange: widget.onLocaleChange),
      wideWidget: const WideWidgetSearch(),
      threshold: 800, // Customize threshold for responsiveness
    );
    
    return adjuster.adjust(context);

  }

}