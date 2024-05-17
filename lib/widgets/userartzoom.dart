import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomImage extends StatelessWidget {
  final File imageFile;
  final String artname;
  final String artist;

  ZoomImage({required this.imageFile, required this.artname, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$artname by $artist'),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: FileImage(imageFile),
        ),
      ),
    );
  }
}
