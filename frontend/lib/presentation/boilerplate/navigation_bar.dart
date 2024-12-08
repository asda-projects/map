import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';

class MyNavigationBar extends StatefulWidget {
  final void Function(int)? onItemTapped;
  final int selectedIndex;

  const MyNavigationBar({super.key, required this.onItemTapped, required this.selectedIndex});

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
   // Track selected tab index

  // Handle tab changes


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white, // Custom background
      currentIndex: widget.selectedIndex, // Active tab
      onTap: widget.onItemTapped, // Tab change callback

      // Active/Inactive icon colors
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,

      // Font sizes and custom label styles
      selectedFontSize: 14,
      unselectedFontSize: 12,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),

      // Navigation Items
      items:  [
        BottomNavigationBarItem(
          icon: Icon(Icons.manage_search_rounded),
          activeIcon: Icon(Icons.manage_search_rounded),
          label: S.of(context).search,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud_download),
          activeIcon: Icon(Icons.cloud_download),
          label: S.of(context).downloadedMusic,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.heart
          ),
          activeIcon: FaIcon(
            FontAwesomeIcons.heart
          ),
          label: S.of(context).favoriteMusic,
        ),
      ],
    );
  }
}
