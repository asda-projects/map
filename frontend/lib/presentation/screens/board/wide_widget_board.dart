
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class WideWidgetBoard extends StatefulWidget {
  const WideWidgetBoard({super.key});

  @override
  WideWidgetBoardState createState() => WideWidgetBoardState();
}

class WideWidgetBoardState extends State<WideWidgetBoard> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    
    return AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options:  ParticleOptions(
            spawnMaxRadius: 50,
            spawnMinSpeed: 10.00,
            particleCount: 20,
            spawnMaxSpeed: 20,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            
            // image: Image(image: AssetImage('assets/images/elephant.png')),
          ),
        ),
        vsync: this,
        child: Container());

  }

}