import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:moseum_application_rasco/data/art.dart';
import 'package:moseum_application_rasco/widgets/artworkdetails.dart';
import 'package:moseum_application_rasco/widgets/userartzoom.dart';

class ArtworkDisplayScreen extends StatefulWidget {
  @override
  _ArtworkDisplayScreenState createState() => _ArtworkDisplayScreenState();
}

class _ArtworkDisplayScreenState extends State<ArtworkDisplayScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Box<Artwork> box = Hive.box<Artwork>('artworks');
    final List<Artwork> selectedArtworks = box.values.toList();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: selectedArtworks.isNotEmpty
                  ? Image.file(
                      File(selectedArtworks[_currentIndex].imglocation),
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.7),
                      colorBlendMode: BlendMode.darken,
                    )
                  : Container(color: Colors.black),
            ),
            Column(
              children: [
                if (selectedArtworks.isNotEmpty)
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
                                  builder: (_) => ZoomImage(
                                    imageFile: File(selectedArtworks[_currentIndex].imglocation),
                                    artname: selectedArtworks[_currentIndex].name,
                                    artist: selectedArtworks[_currentIndex].artist,
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
                                border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 1),
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(255, 95, 94, 92).withOpacity(0.5),
                              ),
                              child: Image.file(
                                File(selectedArtworks[_currentIndex].imglocation),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Gap(10),
                          Text(
                            selectedArtworks[_currentIndex].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: selectedArtworks[_currentIndex].name.length >= 10 ? 20 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Artist: ${selectedArtworks[_currentIndex].artist}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Date: ${selectedArtworks[_currentIndex].date}',
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
                  itemCount: selectedArtworks.length,
                  itemBuilder: (context, index, realIndex) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ArtworkDetailScreen(
                              artwork: selectedArtworks[index],
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
                          child: Image.file(
                            File(selectedArtworks[index].imglocation),
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
