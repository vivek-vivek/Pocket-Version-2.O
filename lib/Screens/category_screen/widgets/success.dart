import 'package:flutter/material.dart';

Future<void> success(BuildContext context) async {
  const snackBars = SnackBar(
    duration: Duration(microseconds: 400),
    content: Text("successfully deleted"),
    backgroundColor: Colors.lightGreen,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBars);
}
