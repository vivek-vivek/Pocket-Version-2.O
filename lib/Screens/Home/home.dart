// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/category_db_f.dart';
import 'package:budgetory_v1/DB/transaction_db_f.dart';
import 'package:budgetory_v1/Screens/All%20Transaction%20screen/Home%20screen/Index/filterd_trasnaction.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';
import '../../DataBase/Models/ModalCategory/category_model.dart';
import 'list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: colorId.purple,
                      ),
                      width: 320.00,
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
                                    const Text(
                                      'Balance',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24.00,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      TransactionDB.instance
                                          .totalTransaction()[0]
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 34.000,
                                        color: colorId.white,
                                        // *text shadow here
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: colorId.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30.00, right: 8.00, left: 8.00),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
// ?Income section----------------------->
                                            const Text(
                                              'Income',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 24.00,
                                                  color: Colors.white),
                                            ),
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
                                            )
                                          ],
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: CategoryDB
                                              .instance.incomeCategoryModelList,
                                          builder: (BuildContext context,
                                              List<CategoryModel> newModel,
                                              Widget? _) {
                                            return Text(
                                              TransactionDB.instance
                                                  .totalTransaction()[1]
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 24.00,
                                                color: colorId.white,
                                                // *text shadow here
                                              ),
                                            );
                                          },
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
                                            const Text(
                                              'Expense',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 24.00,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          TransactionDB.instance
                                              .totalTransaction()[2]
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24.00,
                                            color: colorId.white,
                                            // *text shadow here
                                          ),
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
                      style: TextStyle(fontSize: 10.00),
                    ),
                    TextButton(
                      onPressed: () async {
                        print(DateTime.now().day - 7);

                        print("❤️");
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
        ),
      ),
    );
  }

  final colorId = ColorsID();
}

// !x x x x x  x x x x x x x x  x x x x x x x x x x x x x x x x x x x x x x x x x x x x  x x x x  x xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


