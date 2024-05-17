import 'package:flutter/foundation.dart';
import 'package:moseum_application_rasco/data/art.dart';

class ArtworkProvider extends ChangeNotifier {
  List<Artwork> _artworks = [];

  List<Artwork> get artworks => _artworks;

  void addArtwork(Artwork artwork) {
    _artworks.add(artwork);
    notifyListeners();
  }
}
