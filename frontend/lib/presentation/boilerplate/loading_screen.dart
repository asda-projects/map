import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Color backgroundColor;
  final Color loaderColor;

  const LoadingScreen({
    super.key,
    this.backgroundColor = Colors.white,
    this.loaderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: CircularProgressIndicator(
          color: loaderColor,
        ),
      ),
    );
  }
}
