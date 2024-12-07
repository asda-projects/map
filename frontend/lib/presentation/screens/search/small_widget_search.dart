

import 'package:flutter/material.dart';

// import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:frontend/presentation/boilerplate/app_bar.dart';




class SmallWidgetSearch extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SmallWidgetSearch({
    super.key, required this.onLocaleChange
    });

  @override
  SmallWidgetSearchState createState() => SmallWidgetSearchState();
}

class SmallWidgetSearchState extends State<SmallWidgetSearch> {

  


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
        appBar: MyAppBar(onLocaleChange: widget.onLocaleChange, logoColor: Colors.transparent),

        body: SingleChildScrollView(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              
              Text("Search page")
          
          ])),
      )]);

  }

}