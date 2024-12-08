

import 'package:flutter/material.dart';

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
            
            endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
          ],
        ),
      ),       
        bottomNavigationBar: MyNavigationBar(
          onItemTapped: _onItemTapped,
          selectedIndex: _selectedIndex,
        ),
        body: _screensLins()[_selectedIndex]
        )
        
        ]); }}