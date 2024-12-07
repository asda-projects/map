

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
            AnimatedContainer(
              
              duration: Duration(seconds: 3),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                  Color(0xFFD6A49B).withOpacity(0.7), // Soft pink
                  Colors.grey.shade300,
                  Colors.white.withOpacity(1), // Return to soft pink
                            ],
                ),
              ),
            ), Scaffold(
             extendBodyBehindAppBar: true, // Allows content to extend behind the AppBar
            backgroundColor: Colors.transparent,
       

        body: SingleChildScrollView(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              SizedBox(height: 10),
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                SizedBox(
                width: 400,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search here...",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Spacer(),
            ElevatedButton.icon(
                        onPressed: () {
                        },
                        label: Text(
                          "Search",
                          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          
                          backgroundColor: Theme.of(context).colorScheme.onSurface,
                          shape: RoundedRectangleBorder(
                            //side: BorderSide(color: Theme.of(context).colorScheme.onSurface),
                            borderRadius: BorderRadius.circular(5), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ), // Padding inside the button
                        ),
                      ),
           Spacer(),
           Spacer(),
           Spacer(),
              ])
          
          ])),
      )]);

  }

}