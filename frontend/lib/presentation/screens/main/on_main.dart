

import 'package:flutter/material.dart';
import 'package:frontend/presentation/boilerplate/drawer_menu.dart';

import 'package:frontend/presentation/boilerplate/navigation_bar.dart';
import 'package:frontend/presentation/screens/main/downloaded/on_download.dart';
import 'package:frontend/presentation/screens/main/liked/on_liked.dart';
import 'package:frontend/presentation/screens/main/search/on_search.dart';









class OnMainScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const OnMainScreen({
    super.key, required this.onLocaleChange
    });

  @override
  OnMainScreenState createState() => OnMainScreenState();
}

class OnMainScreenState extends State<OnMainScreen> {
    
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  List<Widget> _screensLins() { 
    
    return <Widget>[
    OnSearchScreen(onLocaleChange: widget.onLocaleChange),
    OnLikedScreen(onLocaleChange: widget.onLocaleChange),
    OnDownloadScreen(onLocaleChange: widget.onLocaleChange),


  ];

  }
  
  

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
            
            endDrawer: MyDrawer(onLocaleChange: widget.onLocaleChange),
        bottomNavigationBar: MyNavigationBar(
          onItemTapped: _onItemTapped,
          selectedIndex: _selectedIndex,
        ),
        body: _screensLins()[_selectedIndex]
        )
        
        ]); }}