import 'package:flutter/material.dart';

class ScreenAdjuster<T> {
  final T smallWidget;
  final T wideWidget;
  final double threshold;

  ScreenAdjuster({
    required this.smallWidget,
    required this.wideWidget,
    this.threshold = 600, // Default threshold for distinguishing small and wide screens
  });

  T adjust(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < threshold ? smallWidget : wideWidget;
  }
}