

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/domain/utils/paths.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:frontend/presentation/boilerplate/app_bar.dart';
import 'package:frontend/presentation/boilerplate/glowing_button.dart';
import 'package:frontend/presentation/utils/navigation.dart';


class SmallWidgetBoard extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SmallWidgetBoard({
    super.key, required this.onLocaleChange
    });

  @override
  SmallWidgetBoardState createState() => SmallWidgetBoardState();
}

class SmallWidgetBoardState extends State<SmallWidgetBoard> {

  


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
                  Theme.of(context).colorScheme.onSecondary, // Fade to red at the edges
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
              SizedBox(height: 70),
              Center(
          child: SvgPicture.asset(
            '${DirPath.media}slogan.svg', // Path to your logo
            height: 400, // Adjust size
          )),
          SizedBox(height: 100),
         GlowingButton(
            onPressed: () {
               
              AppNavigation.navigateToPage(
                context,
                'OnAuthScreen',
                arguments: {
                  'onLocaleChange': widget.onLocaleChange
                },
              );
            },
            icon: Icon(
              Icons.music_note_sharp,
              color: Theme.of(context).colorScheme.onSecondary,
              ), // Your icon
            text: Text(
              S.of(context).listenMusic,
              style: TextStyle(
                fontSize: 14, 
                color: Theme.of(context).colorScheme.onSecondary
              ),
              ),
          ),
      
          
          ])),
      )]);

  }

}