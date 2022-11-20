
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../colors/color.dart';

class CustomDateAll extends StatefulWidget {
  const CustomDateAll({super.key});

  @override
  State<CustomDateAll> createState() => _CustomDateAllState();
}

class _CustomDateAllState extends State<CustomDateAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorId.white,
          iconTheme: IconThemeData(color: colorId.btnColor),
          title: Text("Custom Date",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: colorId.btnColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 30.00),
              )),
        ),
        body:const  SafeArea(
          child:Text("data")
        ));
  }

  
  final colorId = ColorsID();
  final GlobalKey navigator = GlobalKey();
}
