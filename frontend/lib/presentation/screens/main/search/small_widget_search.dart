

import 'package:flutter/material.dart';
import 'package:frontend/data/local/adapter_api_search_music.dart';

import 'package:frontend/domain/services/logs.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:frontend/presentation/boilerplate/form_fields.dart';
import 'package:frontend/presentation/boilerplate/listview.dart';


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
  final TextEditingController _searchController = TextEditingController();
  final MusicAdapter _musicAdapter = MusicAdapter();
  AppLogger logger = AppLogger();

  Future<List<Map<String, dynamic>>>? _searchResults;

  void _searchMusic() async {
  try {
    final results = await _musicAdapter.searchVideos(_searchController.text.trim());
    setState(() {
      _searchResults = Future.value(results);
    });
    
  } catch (e) {
    logger.debug("Search Error: $e");
    setState(() {
      _searchResults = Future.error(e); // Trigger error in FutureBuilder
    });
  }
}


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
                  child: CustomTextFormField(
                    controller: _searchController, 
                    labelText: S.of(context).searchBarPhrase, 
                    fontSize: 12,
                    
                ),
              ),
            
            Spacer(),
            Expanded(
                  flex: 3,
                  child: 
            ElevatedButton.icon(
                        onPressed: _searchMusic,
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
              ]),
              SizedBox(height: 20),
              Center(
                child: 
                Container(
          child: _searchResults == null ? SizedBox() : MyListViewBuilder(searchResults: _searchResults))),
      ],
    ),
  );
}}