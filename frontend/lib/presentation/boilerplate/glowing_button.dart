import 'package:flutter/material.dart';
import 'dart:math';

class GlowingButton extends StatefulWidget {
  final Icon icon;
  final Text text;
  final VoidCallback onPressed;

  const GlowingButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _GlowingButtonState createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: _GlowingShadowPainter(
                animationValue: _controller.value,
              ),
              child: SizedBox(
                width: 220,
                height: 55,
              ),
            );
          },
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20,
                          ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: widget.onPressed,
          icon: widget.icon,
          
          label: 
            widget.text,
            
          
        ),
      ],
    );
  }
}

class _GlowingShadowPainter extends CustomPainter {
  final double animationValue;

  _GlowingShadowPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
      Paint paint = Paint()
    ..shader = SweepGradient(
      colors: [
        Color(0xFFD6A49B).withOpacity(0.8), // Soft pink
        Color(0xFFBFD7ED).withOpacity(0.8), // Warm light blue
        Color(0xFFB3A0C9).withOpacity(0.8), // Muted lavender
        Color(0xFFD6A49B).withOpacity(0.8), // Return to soft pink
      ],
      stops: [0.0, 0.33, 0.66, 1.0], // Evenly distribute colors
      transform: GradientRotation(2 * pi * animationValue),
    ).createShader(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
    )
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-20, -20, size.width + 40, size.height + 40),
        Radius.circular(15),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _GlowingShadowPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
