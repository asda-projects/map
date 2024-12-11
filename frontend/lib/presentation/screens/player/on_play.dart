
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
            AnimatedContainer(
              
              duration: Duration(seconds: 3),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                  Colors.white.withOpacity(1), // Return to soft pink
                  Colors.grey.shade300,
                  Color(0xFFD6A49B).withOpacity(0.7), // Soft pink
                            ],
                ),
              ),
            ), Scaffold(
             extendBodyBehindAppBar: true, // Allows content to extend behind the AppBar
            backgroundColor: Colors.transparent,

        
        body: adjuster.adjust(context)
        )]);

  }

}