


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/remote/firebase_auth_adpter.dart';
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
  late  AudioPlayer _audioPlayer;
  
  final AppLogger logger = AppLogger();
  final FirebaseAuthAdapter _firebaseAuthAdapter = FirebaseAuthAdapter();
  

  

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    
    
    _loadMusic(widget.listMusic[widget.indexMusic]['video_id']);
    
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    
    super.dispose();
  }

  Future<void> _loadMusic(String videoId) async {


    String userId = _firebaseAuthAdapter.currentUser()!.uid;
    
    final url = 'http://${LocalApiPath.baseUrl}${LocalApiPath.routes.reproduceAudio()}$userId/$videoId';
    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();

    
    } catch (e) {
      return ;
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

  Duration parsedDuration(String durationString) {
  final parts = durationString.split(':');
  if (parts.length == 2) {
    final minutes = int.tryParse(parts[0]) ?? 0;
    final seconds = int.tryParse(parts[1]) ?? 0;
    return Duration(minutes: minutes, seconds: seconds);
  }
  return Duration(seconds: 1); // Default to zero if parsing fails
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
                  "http://${LocalApiPath.baseUrl}${LocalApiPath.routes.searchCoverImage()}${widget.listMusic[widget.indexMusic]['video_id']}",
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
          
          SizedBox(height: 20),
        SizedBox(
          width: 360,
          child: LoadingIndicatorSong(audioPlayer: _audioPlayer)
          ),
        SizedBox(height: 10),
          PlayerControls(
            audioPlayer: _audioPlayer,
            onNext: _playNext,
            onPrevious: _playPrevious,
            
          ),
        ]);
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
          icon: Icon(Icons.skip_previous,size: 40),
          onPressed: onPrevious,
        ),
        StreamBuilder<PlayerState>(
  stream: audioPlayer.playerStateStream,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return  Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        ),
      );
    }

    if (snapshot.hasError || !snapshot.hasData) {
      return const Icon(Icons.error_outline, size: 40);
    }

    final state = snapshot.data;
    final isPlaying = state?.playing ?? false;
    final isLoading = state?.processingState == ProcessingState.loading ||
        state?.processingState == ProcessingState.buffering;

    if (isLoading) {
      return  SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      );
    }

    return IconButton(
      icon: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        size: 40,
        ),
      onPressed: () {
        isPlaying ? audioPlayer.pause() : audioPlayer.play();
      },
    );
  },
),
        IconButton(
          icon: Icon(Icons.skip_next,
        size: 40
        ),
          onPressed: onNext,
        ),
      ],
    );
  }
}



class LoadingIndicatorSong extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const LoadingIndicatorSong({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        
        StreamBuilder<Duration?>(
          stream: audioPlayer.durationStream,
          builder: (context, snapshot) {
            final totalDuration = snapshot.data ?? Duration.zero;
            return StreamBuilder<Duration>(
              stream: audioPlayer.positionStream,
              builder: (context, positionSnapshot) {
                final currentPosition = positionSnapshot.data ?? Duration.zero;
                final progress = totalDuration.inMilliseconds > 0
                    ? currentPosition.inMilliseconds /
                        totalDuration.inMilliseconds
                    : 0.0;
                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onSurface),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${_formatDuration(currentPosition)} / ${_formatDuration(totalDuration)}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

