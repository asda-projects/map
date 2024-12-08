

import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/main/downloaded/small_widget_download.dart';
import 'package:frontend/presentation/screens/main/downloaded/wide_widget_download.dart';



import 'package:frontend/presentation/utils/screen_adjuster.dart';

class OnDownloadScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const OnDownloadScreen({
    super.key, 
    required this.onLocaleChange
    });

  @override
  OnDownloadScreenState createState() => OnDownloadScreenState();
}

class OnDownloadScreenState extends State<OnDownloadScreen>  {

  @override
  Widget build(BuildContext context) {

    final adjuster = ScreenAdjuster<Widget>(
      smallWidget: SmallWidgetDownload(onLocaleChange: widget.onLocaleChange),
      wideWidget: const WideWidgetDownload(),
      threshold: 800, // Customize threshold for responsiveness
    );
    
    return adjuster.adjust(context);

  }

}