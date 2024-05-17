import 'package:flutter/material.dart';
import 'package:moseum_application_rasco/data/art.dart';
import 'package:photo_view/photo_view.dart';

class ArtworkDetailScreen extends StatelessWidget {
  final Artwork artwork;

  const ArtworkDetailScreen({Key? key, required this.artwork}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artwork.name),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: AssetImage(artwork.imglocation),
        ),
      ),
    );
  }
}
