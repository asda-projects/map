
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/data/utils/paths.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  
  final Function(Locale) onLocaleChange;
  final Color? logoColor;
  final Color? backgroundColor;

  const MyAppBar({
    super.key, 
    required this.onLocaleChange,
    this.logoColor,
    this.backgroundColor
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

    final iconColor = widget.logoColor ?? Theme.of(context).colorScheme.onSurface;
    final bkgColor = widget.backgroundColor ?? Colors.transparent;

    return AppBar(
          backgroundColor: bkgColor,
          leading: Align(
            alignment: Alignment.center, // Ensures the logo is aligned to the left
            child: SvgPicture.asset(
            '${DirPath.media}logo.svg', // Path to your logo
            height: 40,
            colorFilter: ColorFilter.mode(
            iconColor, // Apply the color here
            BlendMode.srcIn, // Commonly used blend mode for icons
          ),
          ),

           // Optional: Center the logo
        ),

        actions: [
          Padding( padding: EdgeInsets.only(right: 10),
          child: DropdownButton<Locale>(
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
            ))
            ]);
            
  }
  
  }