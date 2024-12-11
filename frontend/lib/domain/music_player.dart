import 'package:flutter/material.dart';
import 'package:frontend/data/utils/paths.dart';
import 'package:frontend/domain/services/logs.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {
  final List<Map<String, dynamic>> listMusic;
  int indexMusic;

  MusicPlayer({required this.listMusic, required this.indexMusic});

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer _audioPlayer;
  AppLogger logger = AppLogger();
  

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadMusic(widget.listMusic[widget.indexMusic]['video_id']);
    
  }

  Future<void> _loadMusic(String videoId) async {
    final url = 'http://${LocalApiPath.baseUrl}${LocalApiPath.routes.streamAudio()}$videoId';
    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      logger.debug("Error loading audio: $e");
    }
  }

  void _playNext() {
    if (widget.indexMusic < widget.listMusic.length - 1) {
      setState(() {
        
        widget.indexMusic++;
      });
      _loadMusic(widget.listMusic[widget.indexMusic]['videoId']);
    }
  }

  void _playPrevious() {
    if (widget.indexMusic > 0) {
      setState(() {
        widget.indexMusic--;
      });
      _loadMusic(widget.listMusic[widget.indexMusic]['videoId']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.listMusic[widget.indexMusic]['title'] ?? S.of(context).noTitle,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text("Channel: ${widget.listMusic[widget.indexMusic]['channel'] ?? S.of(context).unknownChannel}"),
          Text("Views: ${widget.listMusic[widget.indexMusic]['views'] ??  S.of(context).noViews}"),
          Text("Duration: ${widget.listMusic[widget.indexMusic]['duration'] ?? S.of(context).unknownDuration}"),
          PlayerControls(
            audioPlayer: _audioPlayer,
            onNext: _playNext,
            onPrevious: _playPrevious,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

class PlayerControls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  PlayerControls({
    required this.audioPlayer,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed: onPrevious,
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            final isPlaying = state?.playing ?? false;
            return IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                isPlaying ? audioPlayer.pause() : audioPlayer.play();
              },
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: onNext,
        ),
      ],
    );
  }
}
