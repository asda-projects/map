

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/domain/utils/paths.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:frontend/presentation/boilerplate/app_bar.dart';


class SmallWidget extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SmallWidget({
    super.key, required this.onLocaleChange
    });

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
        appBar: MyAppBar(onLocaleChange: widget.onLocaleChange),

        body: SingleChildScrollView(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              Center(
          child: SvgPicture.asset(
            '${DirPath.media}on_board_background.svg', // Path to your logo
            height: 500, // Adjust size
          )),
          SizedBox(height: 70),
         ElevatedButton.icon(
            onPressed: () {
              // Define what happens when the button is pressed
            },
            icon: const Icon(Icons.music_note_sharp), // Your icon
            label: Text(
               S.of(context).listenMusic,
               style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Rounded corners
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ), // Padding inside the button
            ),
          ),
      
          
          ])),
      )]);

  }

}