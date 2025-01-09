import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/domain/services/music_service.dart';

class LikeButton extends StatefulWidget {

  final String userId;
  final Map musicData;
  const LikeButton({
    super.key, 
    required this.userId, 
    required this.musicData
    });

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;
  MusicService? musicService;
  // bool _isMusicServiceInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeMusicService();
  }

  Future<void> _initializeMusicService() async {
    musicService = await MusicService.getInstance(dotenv.env['CRYPTOGRAPHER_KEY']!);
    // _isMusicServiceInitialized = true;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // Print the current state
    if (isLiked) {
      var payload = mappedPayload();
      like(payload);
    } else {
      unLike();
    }
  }

  Map mappedPayload() {

    widget.musicData['userId'] = widget.userId;

    return  widget.musicData;
  }

  void like(Map payload) async {
      musicService!.likeMusic(payload);
  }

    void unLike() async {

  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: toggleLike,
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
        size: 36.0,
      ),
    );
  }
}