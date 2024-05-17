import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moseum_application_rasco/models/boxes.dart';
import 'package:moseum_application_rasco/screens/menuscreen.dart';
import 'package:moseum_application_rasco/screens/overviewscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/menubg.jpg'),
              fit: BoxFit.fill,
              opacity: 0.9
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                   const Text('Welcome to', style: TextStyle(
                      fontSize: 25, 
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset.zero
                      )
                    ]
                    ),
                    ),
                   Text('MOSEUM', style: GoogleFonts.playfairDisplay(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    shadows: [
                      const Shadow(
                        blurRadius: 30.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      )
                    ]
                    ),
                    ),
                    const Gap(10),
                    const Text('Your mobile museum application', style: TextStyle(
                      fontSize: 20, 
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      )
                    ]
                    ),),
                    const Gap(25),
                    ElevatedButton(onPressed: (){
                      // print('entered');
                      if(!userbox.isEmpty){
                      Navigator.of(context).push(CupertinoPageRoute(builder: (_)=> Menuscreen()));
                      }else{
                        Navigator.of(context).push(CupertinoPageRoute(builder: (_)=> OverviewScreen()));
                      }
                    }, style: const ButtonStyle(
                      shadowColor: MaterialStatePropertyAll(Colors.white),
                      padding: MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.only(
                          left: 50,
                          right: 50,
                          top: 15,
                          bottom: 15
                        )
                      ),
                      backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 27, 26, 26)),
                    ), child:  Text('ENTER', 
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        color: Colors.white
                      ),
                    ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}