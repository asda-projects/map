


import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/remote/firebase_auth_adpter.dart';
import 'package:frontend/data/utils/paths.dart';
import 'package:frontend/domain/services/logs.dart';
import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:frontend/presentation/boilerplate/like_music_button.dart';
import 'package:frontend/presentation/boilerplate/share_music_button.dart';
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
    
      _audioPlayer.processingStateStream.listen((state) async {
      if (state == ProcessingState.ready) {
        await _audioPlayer.play(); // Automatically play when ready
      }
    });
    
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
      // Set the URL and prepare the audio player
      await _audioPlayer.setUrl(url);

      // Wait until the player is ready or transitions out of buffering/loading state
      //_audioPlayer.processingStateStream.firstWhere((state) =>
      //    state == ProcessingState.ready ||
      //    state == ProcessingState.completed ||
     //     state == ProcessingState.idle);

    // Automatically play once ready
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

  Duration totalDuration(String durationString) {
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
          Center(
            child: Text(
            widget.listMusic[widget.indexMusic]['title'] ?? S.of(context).noTitle,
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
              
              ),
          )),
          SizedBox(height: 10),
          Container(
            height: 200,
            width: 250,
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
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
            widget.listMusic[widget.indexMusic]['channel'] ?? S.of(context).unknownChannel,
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface
              
              )),
          
          SizedBox(height: 20),
          
        SizedBox(
          width: 360,
          child: LoadingIndicatorPlayer(
            audioPlayer: _audioPlayer, 
            totalDuration: totalDuration(
            widget.listMusic[widget.indexMusic]['duration']
          ))
          ),
        SizedBox(height: 45),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: [
            LikeButton(),
          PlayerControls(
            audioPlayer: _audioPlayer,
            onNext: _playNext,
            onPrevious: _playPrevious,
            
          ),
          ShareButton(
            songTitle: widget.listMusic[widget.indexMusic]['title'] ?? S.of(context).noTitle, 
            videoId: widget.listMusic[widget.indexMusic]['video_id'],
            
          ),
          
          ]),
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


class LoadingIndicatorPlayer extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final Duration totalDuration; // Pre-computed total duration passed as a param

  const LoadingIndicatorPlayer({
    super.key,
    required this.audioPlayer,
    required this.totalDuration,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoadingIndicatorPlayerState createState() => _LoadingIndicatorPlayerState();
}

class _LoadingIndicatorPlayerState extends State<LoadingIndicatorPlayer> {
  Duration _currentPosition = Duration.zero;
  late StreamSubscription<Duration> _positionSubscription;
  
  @override
  void initState() {
    super.initState();

    // Listen to the current position and update the UI
    _positionSubscription = widget.audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });
    
  }

  @override
  void dispose() {
    // Cancel the subscription to avoid calling setState() after dispose
    _positionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          min: 0.0,
          max: widget.totalDuration.inMilliseconds.toDouble(),
          value: _currentPosition.inMilliseconds.toDouble().clamp(0.0, widget.totalDuration.inMilliseconds.toDouble()),
          onChanged: (value) {
            setState(() {
              _currentPosition = Duration(milliseconds: value.toInt());
            });
          },
          onChangeEnd: (value) {
            widget.audioPlayer.seek(Duration(milliseconds: value.toInt()));
          },
          activeColor: Theme.of(context).colorScheme.onSurface,
          inactiveColor: Theme.of(context).colorScheme.onSecondary,
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(_currentPosition),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              _formatDuration(widget.totalDuration),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
