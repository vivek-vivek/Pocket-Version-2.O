import 'package:flutter/material.dart';

Future<void> success(BuildContext context) async {
  const snackBars = SnackBar(
    content: Text("successfully deleted"),
    backgroundColor: Colors.lightGreen,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBars);
}
