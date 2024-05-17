import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moseum_application_rasco/data/art.dart';
import 'package:moseum_application_rasco/models/boxes.dart';
import 'package:moseum_application_rasco/screens/myartworks.dart';
import 'package:moseum_application_rasco/widgets/upload.dart';

class MyMuseumScreen extends StatefulWidget {
  @override
  _MyMuseumScreenState createState() => _MyMuseumScreenState();
}

class _MyMuseumScreenState extends State<MyMuseumScreen> {
  final box = Hive.box<Artwork>('artworks');

  void _addArtwork(Artwork artwork) {
    box.add(artwork);
  }

  void _showUploadForm() {
    showDialog(
      context: context,
      builder: (context) {
        return ArtworkUploadForm(
          onSubmit: _addArtwork,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Museum"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                const Icon(Icons.brush),
                Text(userbox.get('alias').artistname),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showUploadForm,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: const Color.fromARGB(255, 190, 189, 189),
        hoverColor: Colors.black,
        tooltip: "Add an Artwork",
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Artwork> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                'No artworks found',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return ArtworkDisplayScreen(); 
          }
        },
      ),
    );
  }
}
