import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Moseum'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Gap(10),
                    Text(
                      'Moseum',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Text(
                'Overview',
                style: GoogleFonts.merriweather(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10),
              Text(
                'Moseum is an innovative mobile application designed to bring the art gallery experience to your fingertips. Whether you are an art enthusiast, a student, or a casual observer, Moseum offers a vast collection of digital artworks from various genres, including realism, abstract, historical, and more.',
                style: GoogleFonts.merriweather(
                  fontSize: 16,
                ),
              ),
              const Gap(20),
              Text(
                'Key Features',
                style: GoogleFonts.merriweather(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10),
              Text(
                '• Explore various types of artworks: Digital, Realism, Paintings, Illusion, Abstract, Drawings, and Historical.\n'
                '• Save your favorite artworks to revisit later.\n'
                '• Personalized recommendations based on your preferences.\n'
                '• Artist alias creation to personalize your experience.\n'
                '• User-friendly interface with a seamless browsing experience.',
                style: GoogleFonts.merriweather(
                  fontSize: 16,
                ),
              ),
              const Gap(20),
              Text(
                'About the Creator',
                style: GoogleFonts.merriweather(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10),
              Text(
                'Moseum was created by Tristan Rasco, a passionate developer and art enthusiast. Tristan aims to bridge the gap between technology and art, making it accessible to a wider audience through this innovative platform.',
                style: GoogleFonts.merriweather(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
