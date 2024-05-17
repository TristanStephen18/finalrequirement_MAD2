import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:moseum_application_rasco/data/art.dart';
import 'package:moseum_application_rasco/data/preferences.dart';
import 'package:moseum_application_rasco/models/boxes.dart';
import 'package:moseum_application_rasco/screens/aboutscreen.dart';
import 'package:moseum_application_rasco/screens/museummain.dart';
import 'package:moseum_application_rasco/screens/mymuseum.dart';

class Menuscreen extends StatefulWidget {
  Menuscreen({super.key});

  @override
  State<Menuscreen> createState() => _MenuscreenState();
}

class _MenuscreenState extends State<Menuscreen> {
  final preferencesBox = Hive.box<Preferences>('preferences');
  final box = Hive.box<Artwork>('artworks');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
         child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent
                ),
                child: Text('MOSEUM', style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    shadows: [
                      const Shadow(
                        blurRadius: 20.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      )
                    ]
                    ),
                    ),
              ) 
            ),
            const Gap(10),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text("About"),
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(builder: (_)=>AboutScreen()));
              },
            ),
            const Gap(10),
            const Divider(),
              ListTile(
                leading: const  Icon(Icons.logout),
                title: const Text('Exit Moseum'),
                onTap: () {
                },
              ),

          ],
         ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('MOSEUM', style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    shadows: [
                      const Shadow(
                        blurRadius: 20.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      )
                    ]
                    ),
                    ),
          actions: [
            TextButton(onPressed: (){}, child:  Row(
              children: [
                const Icon(Icons.brush),
                Text(userbox.get('alias').artistname),
              ],
            ))
          ],
          ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/menubg.jpg'),
            fit: BoxFit.fill, 
            opacity: 0.4
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  const Gap(50),
                  Text('Where do you want to go?', style: GoogleFonts.playfairDisplay(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),),
                  const Gap(5),
                  const Text('Choose where you want to explore', style: TextStyle(
                    fontSize: 17
                  ),),
                  const Gap(50),
                  Column(
                    children: [
                      _buildImageButton(
                        context, 
                        'assets/images/choice2.jpg', 
                        'My Museum', 
                        () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (_)=>MyMuseumScreen()));
                        }
                      ),
                      const Gap(20),
                      _buildImageButton(
                        context, 
                        'assets/images/choice1.jpg', 
                        'Main Museum', 
                        () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (_)=>MainMuseumScreen()));
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageButton(BuildContext context, String imagePath, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white, 
                width: 2.0, 
              ),
              borderRadius: BorderRadius.circular(8.0), 
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0), 
              child: Image.asset(
                imagePath,
                width: 400,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(5),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.merriweather(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
