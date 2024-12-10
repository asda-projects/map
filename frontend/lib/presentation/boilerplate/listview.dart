import 'package:flutter/material.dart';
import 'package:frontend/domain/models/music_card.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';

class MyListViewBuilder extends StatefulWidget {
  final Future<List<Map<String, dynamic>>>? searchResults;

  const MyListViewBuilder({
    super.key,
    required this.searchResults,
  });

  @override
  _MyListViewBuilderState createState() => _MyListViewBuilderState();
}

class _MyListViewBuilderState extends State<MyListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: widget.searchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
               S.of(context).searchErrorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
               S.of(context).noResultsFound,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          );
        }

        final results = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final video = results[index];

            return MusicCard(
              title: video['title'] ?? 'No Title', // Replace with localized string
              channel: video['channel'] ?? 'Unknown Channel',
              duration: video['duration'] ?? 'Unknown Duration',
              views: video['views'] ?? 'No Views',
              videoId: video['video_id'] ?? '',
            );
          },
        );
      },
    );
  }
}
