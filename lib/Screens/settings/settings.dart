// ignore_for_file: avoid_print

import 'package:budgetory_v1/screens/settings/about_us.dart';
import 'package:budgetory_v1/screens/settings/privacy_policey.dart';
import 'package:budgetory_v1/screens/settings/terms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorId.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    "About Us",
                    style: TextStyle(color: colorId.btnColor),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorId.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    "Privacy Policy",
                    style: TextStyle(color: colorId.btnColor),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrivacyPolices()));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: colorId.white,
                  border: Border.all(color: colorId.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  title: Text("Terms & Conditions",
                      style: TextStyle(color: colorId.btnColor)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TermsAndCondition()));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: colorId.white,
                  border: Border.all(color: colorId.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  trailing: const Icon(Icons.restart_alt_outlined),
                  title: Text("Reset app",
                      style: TextStyle(color: colorId.btnColor)),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return SimpleDialog(
                          children: [
                            Center(
                              child: Text(
                                "Dou want to Reset App?",
                                style: GoogleFonts.lato(
                                    color: colorId.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await CategoryDB.instance.deleteDBAll();
                                    await TransactionDB.instance.deleteDBAll();
                                    TransactionDB.instance.T == 0.0;
                                    await TransactionDB.instance
                                        .refreshUiTransaction();

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SplashScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "reset",
                                    style: GoogleFonts.lato(
                                        color: colorId.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "cancel",
                                    style: GoogleFonts.lato(
                                        color: colorId.lightGreen,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final colorId = ColorsID();

  clear() async {
    TransactionDB.instance.totalListNotifier.value.clear();
    TransactionDB.instance.totalListNotifier.notifyListeners();

    TransactionDB.instance.incomeTotalListNotifier.value.clear();
    TransactionDB.instance.incomeTotalListNotifier.notifyListeners();

    TransactionDB.instance.expenceTotalListNotifier.value.clear();
    TransactionDB.instance.expenceTotalListNotifier.notifyListeners();
  }
}
