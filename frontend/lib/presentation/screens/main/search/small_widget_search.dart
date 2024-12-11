


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/data/local/adapter_api_search_music.dart';

import 'package:frontend/domain/services/logs.dart';
import 'package:frontend/domain/services/music_service.dart';
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

class SmallWidgetSearchState extends State<SmallWidgetSearch>  {
  final TextEditingController _searchController = TextEditingController();
  final MusicAdapter _musicAdapter = MusicAdapter();
  AppLogger logger = AppLogger();

  Future<List<Map<String, dynamic>>>? _searchResults;
  MusicService? musicService;
  bool _isMusicServiceInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeMusicService();
  }

  // Initialize the music service and load previous search results if available
  Future<void> _initializeMusicService() async {
    musicService = await MusicService.getInstance(dotenv.env['CRYPTOGRAPHER_KEY']!);
    _isMusicServiceInitialized = true;

    final cachedMusic = await musicService?.loadMusic();
    if (cachedMusic != null && cachedMusic.isNotEmpty) {
      logger.debug("Cache was loaded!");
      setState(() {
        _searchResults = Future.value(cachedMusic);
      });
    }
  }

  // Perform a search and save results to cache
  void _searchMusic() async {
    if (!_isMusicServiceInitialized || musicService == null) {
      await _initializeMusicService();
    }

    try {
      final query = _searchController.text.trim();
      if (query.isEmpty) {
        
        return;
      }
      
      // Search videos
      final results = await _musicAdapter.searchVideos(query);

      if (results.isNotEmpty) {
        setState(() {
          _searchResults = Future.value(results);
        });

        // Save results to cache
        await musicService?.saveMusic(results);
        
        
      } else {
        logger.debug("No search results found.");
      }
    } catch (e) {
      logger.debug("Search Error: $e");
      setState(() {
        _searchResults = Future.error(e); // Trigger error in FutureBuilder
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    
    
    return  SingleChildScrollView(
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