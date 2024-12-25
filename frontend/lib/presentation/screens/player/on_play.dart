
import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/player/small_widget_play.dart';
import 'package:frontend/presentation/screens/player/wide_widget_play.dart';


import 'package:frontend/presentation/utils/screen_adjuster.dart';

class OnPlayScreen extends StatefulWidget {
    final List<Map<String, dynamic>> listMusic;
  final int indexMusic;
  

  const OnPlayScreen({
    super.key, required this.listMusic, required this.indexMusic
    });

  @override
  OnPlayScreenState createState() => OnPlayScreenState();
}

class OnPlayScreenState extends State<OnPlayScreen>  {

  @override
  Widget build(BuildContext context) {

    final adjuster = ScreenAdjuster<Widget>(
      smallWidget: SmallWidgetPlay(            
        listMusic: widget.listMusic,
        indexMusic: widget.indexMusic
        ),
      wideWidget: const WideWidgetPlay(),
      threshold: 800, // Customize threshold for responsiveness
    );
    
    return Stack(
        children: [
          // Gradient background
            AnimateGradient(
                primaryColors: [
                  Theme.of(context).primaryColor, // Dusty Rose
                  Theme.of(context).primaryColor.withOpacity(0.4), // Decayed Dusty Rose
                  Theme.of(context).colorScheme.onSecondary
                ],
                secondaryColors: [
                  Theme.of(context).colorScheme.onSecondary,
                  Theme.of(context).primaryColor.withOpacity(0.4), // Muted Dusty Rose
                  Theme.of(context).primaryColor
                ],
              ), Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
              ),
             extendBodyBehindAppBar: true, // Allows content to extend behind the AppBar
            backgroundColor: Colors.transparent,

        
        body: adjuster.adjust(context)
        )]);

  }

}