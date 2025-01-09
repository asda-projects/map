

import 'package:flutter/material.dart';
import 'package:frontend/domain/music_player.dart';




class SmallWidgetPlay extends StatefulWidget {
    final List<Map<String, dynamic>> listMusic;
  final int indexMusic;
  

  const SmallWidgetPlay({
    super.key, required this.listMusic, required this.indexMusic
    });

  @override
  SmallWidgetPlayState createState() => SmallWidgetPlayState();
}

class SmallWidgetPlayState extends State<SmallWidgetPlay> {

  


  @override
  Widget build(BuildContext context) {

  
    return  MusicPlayer(
            listMusic: widget.listMusic,
            indexMusic: widget.indexMusic,
          );


  }

}