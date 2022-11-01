import 'package:flutter/material.dart';

import '../../colors/color.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorId.lightBlue,
      body: const SafeArea(
        child: Text(
            "AppSamurai is an equal opportunity startup for everyone. Our team is made of individuals ready to “build from scratch” and so we’re always looking for members eager to learn and grow – regardless of whether they’re in the early years of their careers or senior level."),
      ),
    );
  }

  final colorId = ColorsID();
}
