

import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/board/small_widget.dart';
import 'package:frontend/presentation/screens/board/wide_widget.dart';
import 'package:frontend/presentation/utils/screen_adjuster.dart';

class OnBoardScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const OnBoardScreen({
    super.key, 
    required this.onLocaleChange
    });

  @override
  OnBoardScreenState createState() => OnBoardScreenState();
}

class OnBoardScreenState extends State<OnBoardScreen>  {

  @override
  Widget build(BuildContext context) {

    final adjuster = ScreenAdjuster<Widget>(
      smallWidget: SmallWidget(onLocaleChange: widget.onLocaleChange),
      wideWidget: const WideWidget(),
      threshold: 800, // Customize threshold for responsiveness
    );
    
    return adjuster.adjust(context);

  }

}