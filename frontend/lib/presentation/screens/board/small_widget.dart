

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/domain/utils/paths.dart';

class SmallWidget extends StatefulWidget {
  const SmallWidget({super.key});

  @override
  SmallWidgetState createState() => SmallWidgetState();
}

class SmallWidgetState extends State<SmallWidget> {
  @override
  Widget build(BuildContext context) {
    
    return Stack(
        children: [
          // Gradient background
          Container(
            decoration:  BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft, // Position the sun in the top-left corner
                radius: 1.5, // Size of the sun
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  Colors.white, // Fade to red at the edges
                ],
                stops: [0.07, 0.1, 0.28], // Control the gradient spread
              ),
            ),
          ), Scaffold(
             extendBodyBehindAppBar: true, // Allows content to extend behind the AppBar
            backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Align(
            alignment: Alignment.center, // Ensures the logo is aligned to the left
            child: SvgPicture.asset(
            '${DirPath.media}logo.svg', // Path to your logo
            height: 40, // Adjust size
          ),

           // Optional: Center the logo
        )),
        body: Center(
          child: SvgPicture.asset(
            '${DirPath.media}on_board_background.svg', // Path to your logo
            height: 500, // Adjust size
          ),
        ),
      )]);

  }

}