import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/data/remote/firebase_auth_adpter.dart';
import 'package:frontend/domain/utils/paths.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:frontend/presentation/utils/navigation.dart';

class MyDrawer extends StatefulWidget {
  final String headerTitle;
  final Color headerColor;
  final TextStyle headerTextStyle;
  final Function(Locale) onLocaleChange; // Callback for locale change

  const MyDrawer({
    super.key,
    required this.onLocaleChange, // Required callback
    this.headerTitle = 'Menu',
    this.headerColor = const Color(0xFFD6A49B),
    this.headerTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  FirebaseAuthAdapter firebaseAuth = FirebaseAuthAdapter();
  Locale _selectedLocale = const Locale('en'); // Default language

  @override
  Widget build(BuildContext context) {
    return Drawer(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch, // Expand width
    children: [
      // Full-Width Drawer Header
      SizedBox(
        width: double.infinity, // Ensures full width
        child: DrawerHeader(
          decoration: BoxDecoration(color: widget.headerColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                '${DirPath.media}logo.svg', // Path to your logo
                height: 50,
              ),
              const Spacer(),
              const Text(
                "Heartbeats",
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),

      // ExpansionTile (Language Selection)
      ExpansionTile(
        leading: const FaIcon(FontAwesomeIcons.language, color: Colors.black54),
        title: Text(S.of(context).selectedLanguage),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          _buildLanguageTile(context, const Locale('en'), 'English'),
          _buildLanguageTile(context, const Locale('pt'), 'Português'),
          _buildLanguageTile(context, const Locale('th'), 'ไทย'),
        ],
      ),

      // Spacer pushes ListTile (Logout) to the bottom
      const Spacer(),

      // Logout Button
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: Text(S.of(context).logout),
          onTap: () {
            firebaseAuth.logout();
            // Navigator.pop(context);
            AppNavigation.refreshApp(context);
          },
        ),
      ),
    ],
  ),
);


  }

  /// Builds each language selection tile
  Widget _buildLanguageTile(BuildContext context, Locale locale, String label) {
    return ListTile(
      title: Text(label),
      onTap: () {
        
        setState(() {
          _selectedLocale = locale;
        });

        widget.onLocaleChange(locale);
        Navigator.pop(context);
      },
    );
  }
}
