import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/utils/paths.dart';
import 'package:frontend/domain/services/logs.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:frontend/presentation/utils/navigation.dart';

class MusicCard extends StatelessWidget {
  final List<Map<String, dynamic>> listMusic;
  final int indexMusic;
  final String title;
  final String channel;
  final String duration;
  final String views;
  final String videoId;

  MusicCard({
    super.key,
    required this.listMusic, 
    required this.indexMusic,
    required this.title,
    required this.channel,
    required this.duration,
    required this.views,
    required this.videoId, 
  });

  final AppLogger logger = AppLogger();
  

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0),
      shadowColor: Theme.of(context).colorScheme.onSurface.withOpacity(0),
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
    borderRadius: BorderRadius.circular(5),
    focusColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
    onTap: () {
      AppNavigation.navigateToPage(
        context,'OnPlayScreen',
         arguments: {'listMusic': listMusic, 'indexMusic': indexMusic}
        );
      
    },
    child: Row(
        children: [
          // Video Thumbnail Placeholder
          Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  'http://${LocalApiPath.baseUrl}${LocalApiPath.routes.searchCoverImage()}$videoId',
              placeholder: (context, url) => Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
              ))),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline, size: 40),
              fit: BoxFit.cover,
            ),
          ),

          // Text Details
          const SizedBox(width: 8), // Add some spacing
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    S.of(context).channel(channel),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    S.of(context).views(views),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    S.of(context).duration(duration),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
