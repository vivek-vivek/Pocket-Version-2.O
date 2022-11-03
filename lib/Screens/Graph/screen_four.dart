import 'dart:html';

import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatelessWidget {
  GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
//^----------------------------------Graphs------------------------------------
              SizedBox(
                height: 350.000,
                child: ColoredBox(
                  color: colorId.lightBlue,
                  child: Text("data"),
                ),
              ),
//^----------------------------------End---------------------------------------
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: filtering(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final colorId = ColorsID();
}

filtering() {
  Text("data");
}
