import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moseum_application_rasco/data/art.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:hive/hive.dart';

class ArtworkUploadForm extends StatefulWidget {
  final Function(Artwork) onSubmit;

  ArtworkUploadForm({required this.onSubmit});
  @override
  _ArtworkUploadFormState createState() => _ArtworkUploadFormState();
}

class _ArtworkUploadFormState extends State<ArtworkUploadForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _artist;
  late String _date;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<String> _saveImageToLocalDirectory(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final folderPath = path.join(directory.path, 'artworks');
    final folder = Directory(folderPath);

    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final fileName = path.basename(image.path);
    final localImage = await image.copy(path.join(folderPath, fileName));
    return localImage.path;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _image != null) {
      final savedImagePath = await _saveImageToLocalDirectory(_image!);
      _formKey.currentState!.save();
      final artwork = Artwork(
        name: _name,
        artist: _artist,
        date: _date,
        imglocation: savedImagePath,
      );

      final box = Hive.box<Artwork>('artworks');
      setState(() {
        box.add(artwork);
      });

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Upload Artwork'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Artwork Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the artwork name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Artist Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the artist name';
                  }
                  return null;
                },
                onSaved: (value) => _artist = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
                onSaved: (value) => _date = value!,
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: () {
                  _pickImage(context);
                },
                child: const Text('Upload Artwork Image'),
              ),
              if (_image != null) Image.file(_image!),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
