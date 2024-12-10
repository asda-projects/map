

import 'package:flutter/material.dart';
import 'package:frontend/data/local/adapter_api_search_music.dart';
import 'package:frontend/domain/models/music_card.dart';
import 'package:frontend/domain/services/logs.dart';
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
                  child: TextField(
                    controller: _searchController,
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

              Center(
                child: 
                Container(
          child: _searchResults == null
              ? SizedBox()
              : FutureBuilder<List<Map<String, dynamic>>>(
          future: _searchResults,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  S.of(context).searchErrorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                    ),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(S.of(context).noResultsFound, style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                    )),
              );
            }

            final results = snapshot.data!;

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final video = results[index];

                return MusicCard(
                  title: video['title'] ?? S.of(context).noTitle,
                  channel: video['channel'] ?? S.of(context).unknownChannel,
                  duration: video['duration'] ?? S.of(context).unknownDuration,
                  views: video['views'] ?? S.of(context).noViews,
                  videoId: video['video_id'] ?? '',
                );
              },
            );
          },
        ))),
      ],
    ),
  );
}}