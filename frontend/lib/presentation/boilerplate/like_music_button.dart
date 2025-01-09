import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // Print the current state
    if (isLiked) {
      print("Liked");
    } else {
      print("Unliked");
    }
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