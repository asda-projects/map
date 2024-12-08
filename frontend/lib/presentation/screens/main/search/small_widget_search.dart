

import 'package:flutter/material.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';


// import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';







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

    
    
    return SingleChildScrollView(
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
                 Expanded(
                  flex: 6,
                  child: TextField(
                decoration: InputDecoration(
                  hintText: S.of(context).searchBarPhrase,
                  hintStyle: TextStyle(
                    fontSize: 12
                  ),
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
            Expanded(
                  flex: 3,
                  child: 
            ElevatedButton.icon(
                        onPressed: () {
                        },
                        label: Text(S.of(context).search,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 12,
                            
                            ),
                            
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          
                          backgroundColor: Theme.of(context).colorScheme.onSurface,
                          shape: RoundedRectangleBorder(
                            //side: BorderSide(color: Theme.of(context).colorScheme.onSurface),
                            borderRadius: BorderRadius.circular(5), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ), // Padding inside the button
                        ),
                      )),
           Spacer(),
            
            IconButton(
              icon: const Icon(Icons.menu), 
              onPressed: () {
              Scaffold.of(context).openEndDrawer(); // Open right drawer
            },
            ),
           Spacer(),
              ])
          
          ]));

  }

}