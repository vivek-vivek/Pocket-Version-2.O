// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/category_db_f.dart';
import 'package:budgetory_v1/DB/transaction_db_f.dart';
import 'package:budgetory_v1/Screens/all_transaction_screen/home_screen/main_screen/filterd_trasnaction.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:budgetory_v1/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    TransactionDB.instance.totalTransaction();
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 400.00,
                height: 300.00,
                decoration: BoxDecoration(
                  color: colorId.mainBlue,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.00, top: 75.00),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: colorId.btnColor,
                  ),
                  width: 360.00,
                  height: 202.00,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // ? balance section---------->
                                Text(
                                  TransactionDB.instance.totalTransaction()[0] <
                                          0
                                      ? 'Lose'
                                      : 'Balance',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.00,
                                    color: TransactionDB.instance
                                                .totalTransaction()[0] <
                                            0
                                        ? colorId.red
                                        : colorId.lightGreen,
                                  ),
                                ),
                                // ValueListenableBuilder(
                                //     valueListenable: TransactionDB
                                //         .instance.totalListNotifier,
                                //     builder: (BuildContext context,
                                //         List<double> newList, Widget? _) {
                                //       return Text(
                                //         TransactionDB.instance.totalListNotifier
                                //                 .value.isEmpty
                                //             ? '0'
                                //     : TransactionDB.instance
                                //         .totalListNotifier.value
                                //         .join()
                                //         .toString(),
                                // style: TextStyle(
                                //     fontWeight: FontWeight.w900,
                                //     fontSize: 28.000,
                                //     color: colorId.white),
                                //       );
                                //     })
                                Text(
                                  TransactionDB.instance.T == null
                                      ? '0.0'
                                      : TransactionDB.instance.T.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 28.000,
                                      color: colorId.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.00, right: 35.00, left: 35.00),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: colorId.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.trending_up,
                                            color: colorId.lightGreen,
                                          ),
                                        ),
// ?Income section----------------------->
                                        Text(' Income ',
                                            style: GoogleFonts.lato(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 24.00,
                                                color: Colors.white)),
                                      ],
                                    ),
                                    // ValueListenableBuilder(
                                    //     valueListenable: TransactionDB
                                    //         .instance.incomeTotalListNotifier,
                                    //     builder: (BuildContext context,
                                    //         List<double> newList, Widget? _) {
                                    //       return Text(
                                    //         TransactionDB
                                    //                 .instance
                                    //                 .incomeTotalListNotifier
                                    //                 .value
                                    //                 .isEmpty
                                    //             ? '0'
                                    //             : TransactionDB
                                    //                 .instance
                                    //                 .incomeTotalListNotifier
                                    //                 .value
                                    //                 .join()
                                    //                 .toString(),
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.w900,
                                    //             fontSize: 28.000,
                                    //             color: colorId.white),
                                    //       );
                                    //     })\
                                    Text(
                                      TransactionDB.instance.I == null
                                          ? '0.0'
                                          : TransactionDB.instance.I.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 28.000,
                                          color: colorId.white),
                                    )
                                  ],
                                )
                              ],
                            ),
//?expense section ---------->
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: colorId.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.trending_down_rounded,
                                            color: colorId.red,
                                          ),
                                        ),
                                        Text(' Expense ',
                                            style: GoogleFonts.lato(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 24.00,
                                                color: Colors.white)),
                                      ],
                                    ),
                                    // ValueListenableBuilder(
                                    //     valueListenable: TransactionDB
                                    //         .instance.expenceTotalListNotifier,
                                    //     builder: (BuildContext context,
                                    //         List<double> newList, Widget? _) {
                                    //       return Text(
                                    //         TransactionDB
                                    //                 .instance
                                    //                 .expenceTotalListNotifier
                                    //                 .value
                                    //                 .isEmpty
                                    //             ? '0'
                                    //             : TransactionDB
                                    //                 .instance
                                    //                 .expenceTotalListNotifier
                                    //                 .value
                                    //                 .join()
                                    //                 .toString(),
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.w900,
                                    //             fontSize: 28.000,
                                    //             color: colorId.white),
                                    //       );
                                    //     })
                                    Text(
                                      TransactionDB.instance.E == null
                                          ? '0.0'
                                          : TransactionDB.instance.E.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 28.000,
                                          color: colorId.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    //*first column
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.00),
// ? view all button--->
// ^ Navigator---> ScreenAllT()---->
          Padding(
            padding: const EdgeInsets.only(left: 16.00, right: 10.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 15.00),
                ),
                TextButton(
                  onPressed: () async {
                    Filter.instance
                        .filterTransactionFunction(customMonth: null);
                    TransactionDB().refreshUiTransaction();
                    CategoryDB.instance.refreshUI();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AllTransactionsNew(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 13.00),
                    child: Text(
                      'View all',
                      style: TextStyle(fontSize: 15.00),
                    ),
                  ),
                )
              ],
            ),
          ),

// ?Recent  transactions
          Flexible(child: Tile())
        ],
      ),
    );
  }

  final colorId = ColorsID();
}

// !x x x x x  x x x x x x x x  x x x x x x x x x x x x x x x x x x x x x x x x x x x x  x x x x  x xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


