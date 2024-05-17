import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:moseum_application_rasco/artsdata/abstract.dart';
import 'package:moseum_application_rasco/artsdata/digital.dart';
import 'package:moseum_application_rasco/artsdata/drawings.dart';
import 'package:moseum_application_rasco/artsdata/historical.dart';
import 'package:moseum_application_rasco/artsdata/illusion.dart';
import 'package:moseum_application_rasco/artsdata/paintings.dart';
import 'package:moseum_application_rasco/artsdata/realism.dart';
import 'package:moseum_application_rasco/data/art.dart';
import 'package:moseum_application_rasco/data/data.dart';
import 'package:moseum_application_rasco/data/preferences.dart';
import 'package:moseum_application_rasco/models/boxes.dart';
import 'package:moseum_application_rasco/providers/artworkprovider.dart';
import 'package:moseum_application_rasco/screens/menuscreen.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  bool showForm = false;
  double padding = 20;
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var artProvider = Provider.of<ArtProvider>(context);
    bool hasSelectedChoices = artProvider.choices.values.any((value) => value);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/entranceimage.jpg'),
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color.fromARGB(255, 228, 228, 228),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Gap(showForm ? 30 : 10),
                    Text(
                      'WELCOME TO MUSEUM',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [
                          const Shadow(
                            blurRadius: 10.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                            offset: Offset.zero,
                          )
                        ],
                      ),
                    ),
                    if (showForm)
                      const Gap(110)
                    else
                      const Gap(10),
                    Text(
                      showForm
                          ? "What is your alias as an Artist"
                          : "What kind of artworks would you like to see?",
                      style: GoogleFonts.merriweather(
                        fontSize: showForm ? 18 : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(10),
                    Flexible(
                      child: showForm ? buildForm() : buildPreferences(artProvider),
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (showForm)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showForm = false;
                              });
                            },
                            style: const ButtonStyle(
                              shadowColor: MaterialStatePropertyAll(Colors.white),
                              padding: MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.only(
                                  left: 33,
                                  right: 33,
                                  top: 5,
                                  bottom: 5,
                                ),
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 27, 26, 26)),
                            ),
                            child: const Text(
                              'BACK',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: hasSelectedChoices
                              ? () {
                                  if (showForm) {
                                    if (usernameController.text.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: const Text('Please enter an alias'),
                                            content: const Text('Alias field cannot be empty.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                       try {
                                        userbox.put('alias', Data(artistname: usernameController.text));
                                        artProvider.username = usernameController.text;
                                        Navigator.of(context).pushReplacement(
                                          CupertinoPageRoute(
                                            builder: (_) => Menuscreen(),
                                          ),
                                        );
                                      } catch (e) {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              title: const Text('Error'),
                                              content: Text('Failed to save alias: $e'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                  } else {
                                    if (artProvider.selectedArtworks.length < 3) {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: const Text('Please select at least 3'),
                                            content: const Text('You need to select at least 3 types of artworks.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      setState(() {
                                        showForm = true;
                                      });
                                    }
                                  }
                                }
                              : null,
                          style: ButtonStyle(
                            shadowColor: const MaterialStatePropertyAll(Colors.white),
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.only(
                                left: 33,
                                right: 33,
                                top: 5,
                                bottom: 5,
                              ),
                            ),
                            backgroundColor: showForm
                                ? const MaterialStatePropertyAll(Color.fromARGB(255, 42, 78, 32))
                                : const MaterialStatePropertyAll(Color.fromARGB(255, 27, 26, 26)),
                          ),
                          child: Text(
                            showForm ? 'FINISH' : 'NEXT',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPreferences(ArtProvider artProvider) {
    return ListView(
      children: artProvider.choices.keys.map((String key) {
        return CheckboxListTile(
          title: Text(
            key,
            style: const TextStyle(color: Colors.black),
          ),
          value: artProvider.choices[key],
          onChanged: (bool? value) {
            setState(() {
              artProvider.updateChoice(key, value!);
              List<Artwork> selectedArtworks = [];
              if (artProvider.choices["Digital"] == true) {
                selectedArtworks.addAll(digital);
              }
              if (artProvider.choices["Realism"] == true) {
                selectedArtworks.addAll(realism);
              }
              if (artProvider.choices["Paintings"] == true) {
                selectedArtworks.addAll(paintings);
              }
              if (artProvider.choices["Illusion"] == true) {
                selectedArtworks.addAll(illusions);
              }
              if (artProvider.choices["Abstract"] == true) {
                selectedArtworks.addAll(abstract);
              }
              if (artProvider.choices["Drawings"] == true) {
                selectedArtworks.addAll(drawings);
              }
              if (artProvider.choices["Historical"] == true) {
                selectedArtworks.addAll(historical);
              }
              artProvider.updateSelectedArtworks(selectedArtworks);
            });
          },
        );
      }).toList(),
    );
  }

  Widget buildForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(10),
          TextField(
            controller: usernameController,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 201, 199, 197),
              filled: true,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              labelText: "EG. The Great Tristani",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
