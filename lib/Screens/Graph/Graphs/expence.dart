import 'package:flutter/material.dart';

import '../../../colors/color.dart';

class Expences extends StatelessWidget {
  Expences({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      color: colorId.lightRed,
      ),
    );
  }

  final colorId = ColorsID(); 
}
