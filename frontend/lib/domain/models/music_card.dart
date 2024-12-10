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
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Video Thumbnail Placeholder
          Container(
  height: 60,
  width: 60,
  decoration: BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
  ),
  child: CachedNetworkImage(
    imageUrl: 'http://${LocalApiPath.baseUrl}${LocalApiPath.routes.searchImageCover()}$videoId',
    placeholder: (context, url) => const LinearProgressIndicator(
      minHeight: 4,
    ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal:16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  'Channel: $channel',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Duration: $duration',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Views: $views',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
