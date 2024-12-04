
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/domain/utils/paths.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  
  final Function(Locale) onLocaleChange;

  const MyAppBar({
    super.key, required this.onLocaleChange
    });

  @override
  MyAppBarState createState() => MyAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MyAppBarState extends State<MyAppBar>  {

  Locale _selectedLocale = Locale('en');

  @override
  Widget build(BuildContext context) {

    
    
    return AppBar(
          backgroundColor: Colors.transparent,
          leading: Align(
            alignment: Alignment.center, // Ensures the logo is aligned to the left
            child: SvgPicture.asset(
            '${DirPath.media}logo.svg', // Path to your logo
            height: 40, // Adjust size
          ),

           // Optional: Center the logo
        ),

        actions: [
          DropdownButton<Locale>(
            value: _selectedLocale,
            onChanged: (Locale? locale) {
              if (locale != null) {
                setState(() {
                  _selectedLocale = locale;
                });
                widget.onLocaleChange(locale); // Notify parent widget
              }
            },
            underline: SizedBox(),
            
            icon: Icon(Icons.language), // Ícone de idioma
            items: [
              DropdownMenuItem(value: Locale('en'), child: Text('English')),
              DropdownMenuItem(value: Locale('pt'), child: Text('Português')),
              DropdownMenuItem(value: Locale('th'), child: Text('ไทย')),
            ],
            dropdownColor: Theme.of(context).colorScheme.onSecondary,
            focusColor: Colors.transparent, // Removes the grey focus overlay
            )
            ]);
            
  }
  
  }