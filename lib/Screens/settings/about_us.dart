import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors/color.dart';

class AboutUs extends StatelessWidget {
  AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorId.white,
        iconTheme: IconThemeData(color: colorId.black),
        title: Text(
          '''About Us''',
          style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: colorId.btnColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '''App Developed by''',
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: colorId.btnColor),
              ),
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('Assets/user image.png'),
              ),
              Text(
                '''Vivek''',
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: colorId.btnColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final colorId = ColorsID();
}
