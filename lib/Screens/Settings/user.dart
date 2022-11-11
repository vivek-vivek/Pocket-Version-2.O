// ignore_for_file: avoid_print

import 'package:budgetory_v1/Screens/settings/about.dart';
import 'package:flutter/material.dart';
import '../../DB/category_db_f.dart';
import '../../DB/transaction_db_f.dart';
import '../../colors/color.dart';
import '../splash_screen/splash.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorId.purple,
      appBar: AppBar(
        backgroundColor: colorId.lightBlue,
        title: const Text("Setting"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: 200.00,
                height: 80.00,
                decoration: BoxDecoration(
                  color: colorId.lightBlue,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AboutScreen()));
                  },
                  child: const Text("About Us"),
                ),
              ),
              Container(
                width: 200.00,
                height: 80.00,
                decoration: BoxDecoration(
                  color: colorId.lightBlue,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    CategoryDB.instance.deleteDBAll();
                    TransactionDB.instance.deleteDBAll();
                    TransactionDB.instance.totalTransaction().clear();

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SplashScreen()));
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'rest app',
                          style: TextStyle(color: colorId.purple),
                        ),
                        const Icon(Icons.refresh_rounded)
                      ],
                    ),
                  ),
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
