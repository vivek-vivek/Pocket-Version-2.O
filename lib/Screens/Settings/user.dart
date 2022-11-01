// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/FunctionsCategory/category_db_f.dart';
import 'package:budgetory_v1/DB/Transactions/transaction_db_f.dart';
import 'package:flutter/material.dart';
import '../../colors/color.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorId.white,
      appBar: AppBar(
        backgroundColor: colorId.lightBlue,
        title: const Text("Setting"),
      ),
      body: SafeArea(
        child: Column(
          children: const [],
        ),
      ),
    );
  }

  final colorId = ColorsID();
}

//  TextButton(
//               onPressed: () {
//                 CategoryDB.instance.deleteDBAll();
//                 TransactionDB.instance.deleteDBAll();
//               },
//               child: const Text('rest app'),
//             ),
