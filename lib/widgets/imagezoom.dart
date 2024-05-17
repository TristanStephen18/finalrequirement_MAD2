import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableImageScreen extends StatelessWidget {
  final String imageLocation;
  final String artname;
  final String artist;

  ZoomableImageScreen({required this.imageLocation, required this.artname, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artname + " by " + artist),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: AssetImage(imageLocation),
        ),
      ),
    );
  }
}
