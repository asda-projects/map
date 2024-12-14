import 'package:cached_network_image/cached_network_image.dart';
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
      _loadMusic(widget.listMusic[widget.indexMusic]['video_id']);
    }
  }

  void _playPrevious() {
    if (widget.indexMusic > 0) {
      setState(() {
        widget.indexMusic--;
      });
      _loadMusic(widget.listMusic[widget.indexMusic]['video_id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.listMusic[widget.indexMusic]['title'] ?? S.of(context).noTitle,
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface
              
              ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            width: 250,
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  "http://${LocalApiPath.baseUrl}${LocalApiPath.routes.searchImageCover()}${widget.listMusic[widget.indexMusic]['video_id']}",
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
          SizedBox(height: 20),
          
          Text(
            S.of(context).channel("${widget.listMusic[widget.indexMusic]['channel'] ?? S.of(context).unknownChannel}"),
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface
              
              )),
          Text(
            S.of(context).views("${widget.listMusic[widget.indexMusic]['views'] ??  S.of(context).noViews}"),
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface
              
              )),
          Text(
            S.of(context).duration("${widget.listMusic[widget.indexMusic]['duration'] ?? S.of(context).unknownDuration}"),
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface
              
              )),
          SizedBox(height: 20),
          
          PlayerControls(
            audioPlayer: _audioPlayer,
            onNext: _playNext,
            onPrevious: _playPrevious,
            
          ),
        ]);
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
            
            if (snapshot.connectionState == ConnectionState.waiting) {
                return const Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator()),
                );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Icon(Icons.error_outline, size: 40);
        }
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
