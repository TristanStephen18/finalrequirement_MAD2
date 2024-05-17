import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moseum_application_rasco/data/art.dart';
import 'package:moseum_application_rasco/data/data.dart';
import 'package:moseum_application_rasco/data/preferences.dart';
import 'package:moseum_application_rasco/models/boxes.dart';
import 'package:moseum_application_rasco/providers/artworkprovider.dart';
import 'package:moseum_application_rasco/screens/menuscreen.dart';
import 'package:moseum_application_rasco/screens/welcometomoseum.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(ArtworkAdapter());
  Hive.registerAdapter(PreferencesAdapter());
  await Hive.openBox<Artwork>('artworks');
  await Hive.openBox<Preferences>('preferences');
  Hive.registerAdapter((DataAdapter()));
  userbox = await Hive.openBox<Data>('userdata');
   name = await Hive.openBox<String>('artist');
  runApp(Moseumapp());
}

class Moseumapp extends StatelessWidget {
  Moseumapp ({super.key});

  @override
   Widget build(BuildContext context) {
    name.clear();
    return ChangeNotifierProvider(
      create: (context) => ArtProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Museum Application',
        theme: ThemeData.dark(),
        home: const LandingScreen(),
      ),
    );
  }
}