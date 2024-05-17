import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:moseum_application_rasco/data/preferences.dart';
import 'package:moseum_application_rasco/widgets/artworkdetails.dart';
import 'package:moseum_application_rasco/widgets/imagezoom.dart';

class MainMuseumScreen extends StatefulWidget {
  @override
  _MainMuseumScreenState createState() => _MainMuseumScreenState();
}

class _MainMuseumScreenState extends State<MainMuseumScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final preferencesBox = Hive.box<Preferences>('preferences');
    Preferences? preferences;

    for (var value in preferencesBox.values) {
      if (value is Preferences) {
        preferences = value;
        break;
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Main Museum'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.help))
          ],
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: preferences != null && preferences.pref.isNotEmpty
                  ? Image.asset(
                      preferences.pref[_currentIndex].imglocation,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.7),
                      colorBlendMode: BlendMode.darken,
                    )
                  : Container(color: Colors.black),
            ),
            Column(
              children: [
                if (preferences != null && preferences.pref.isNotEmpty)
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ZoomableImageScreen(
                                    artist: preferences!.pref[_currentIndex].artist,
                                    imageLocation: preferences.pref[_currentIndex].imglocation,
                                    artname: preferences.pref[_currentIndex].name,
                                    
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 270,
                              height: 200,
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(255, 255, 255, 255), width: 1),
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(255, 95, 94, 92).withOpacity(0.5),
                              ),
                              child: Image.asset(
                                preferences.pref[_currentIndex].imglocation,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Gap(10),
                          Text(
                            preferences.pref[_currentIndex].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: preferences.pref[_currentIndex].name.length >= 10 ? 20 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Artist: ${preferences.pref[_currentIndex].artist}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Date: ${preferences.pref[_currentIndex].date}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  itemCount: preferences?.pref.length ?? 0,
                  itemBuilder: (context, index, realIndex) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ArtworkDetailScreen(
                              artwork: preferences!.pref[index],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            preferences!.pref[index].imglocation,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
