import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:frontend/data/utils/paths.dart';

class ShareButton extends StatelessWidget {
  final String videoId; // The ID of the video
  final String songTitle; // The title of the song

  const ShareButton({
    super.key,
    required this.videoId,
    required this.songTitle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.share,
        size: 33.0,
      ),
      tooltip: "Share this song",
      onPressed: () {
        _copyToClipboard(context);
      },
    );
  }

  void _copyToClipboard(BuildContext context) {
    final shareContent =
        '${ExternalPath.youtubeWatchVideo}$videoId';

    Clipboard.setData(ClipboardData(text: shareContent));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
