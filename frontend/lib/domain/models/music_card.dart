import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/utils/paths.dart';
import 'package:frontend/domain/services/logs.dart';

class MusicCard extends StatelessWidget {
  final String title;
  final String channel;
  final String duration;
  final String views;
  final String videoId;

  MusicCard({
    super.key,
    required this.title,
    required this.channel,
    required this.duration,
    required this.views,
    required this.videoId,
  });

  AppLogger logger = AppLogger();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0),
      shadowColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // Video Thumbnail Placeholder
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  'http://${LocalApiPath.baseUrl}${LocalApiPath.routes.searchImageCover()}$videoId',
              placeholder: (context, url) => CircularProgressIndicator(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
              ),
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
                    'Channel: $channel',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Views: $views',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Duration: $duration',
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
      ),
    );
  }
}
