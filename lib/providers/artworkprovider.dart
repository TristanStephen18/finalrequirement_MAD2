import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moseum_application_rasco/data/art.dart';
import 'package:moseum_application_rasco/data/preferences.dart';

final preferences = Hive.box<Preferences>('preferences');

class ArtProvider with ChangeNotifier {
  Map<String, bool> choices = {
    "Paintings": false,
    "Abstract": false,
    "Drawings": false,
    "Digital": false,
    "Illusion": false,
    "Realism": false,
    "Historical": false,
  };

  List<Artwork> selectedArtworks = [];
  String username = '';

  void updateChoice(String key, bool value) {
    choices[key] = value;
    notifyListeners();
  }

  void clear(){
    selectedArtworks.clear();
    notifyListeners();
  }

  void updateSelectedArtworks(List<Artwork> artworks) {
    selectedArtworks = artworks;
  Preferences? existingPreferences = preferences.get('preferences') as Preferences?;

  if (existingPreferences != null) {
    existingPreferences.pref.addAll(artworks);
    preferences.put('preferences', existingPreferences);
  } else {
    existingPreferences = Preferences(pref: artworks);
    preferences.put('preferences', existingPreferences);
  }
  notifyListeners();
}

}
