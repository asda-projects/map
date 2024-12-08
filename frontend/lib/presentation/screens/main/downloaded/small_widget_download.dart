

import 'package:flutter/material.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';










class SmallWidgetDownload extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SmallWidgetDownload({
    super.key, required this.onLocaleChange
    });

  @override
  SmallWidgetDownloadState createState() => SmallWidgetDownloadState();
}

class SmallWidgetDownloadState extends State<SmallWidgetDownload> {

  


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
                SizedBox(
                width: 400,
              child: TextField(
                decoration: InputDecoration(
                  hintText: S.of(context).searchBarPhrase,
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
                        label: Text(S.of(context).search,
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
          
          ]));


  }

}