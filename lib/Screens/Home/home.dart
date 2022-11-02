import 'package:budgetory_v1/DB/FunctionsCategory/category_db_f.dart';
import 'package:budgetory_v1/DB/Transactions/transaction_db_f.dart';
import 'package:budgetory_v1/Screens/All%20Transaction%20screen/Home%20screen/Index/screen_all.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';

import '../../DataBase/Models/ModalCategory/category_model.dart';
import 'curosel.dart';
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
              // const SizedBox(
              //   height: 30.00,
              // ),

              // *app bar starting
              ListTile(
                // * showing user name here
                title: Row(
                  children: [
                    Text(
                      'Hello ',
                      style: TextStyle(
                        color: colorId.grey,
                        fontSize: 22.00,
                        shadows: const [
                          Shadow(
                            blurRadius: 10.00,
                            color: Color.fromARGB(248, 219, 216, 216),
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'vivek 🙌',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.00,
                        shadows: [
                          Shadow(
                            blurRadius: 10.00,
                            color: Color.fromARGB(248, 107, 106, 106),
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // * showing user photo here
                trailing: const CircleAvatar(
                  backgroundImage: AssetImage('Assets/user image.png'),
                  radius: 20.00,
                ),
              ),
              const SizedBox(
                height: 10.00,
              ),
              // *app bar end

              Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 40.000, left: 40.00),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: colorId.veryLightGrey),
                        width: 284.00,
                        height: 192.000,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: colorId.lightBlue,
                      ),
                      width: 294.00,
                      height: 202.00,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Column(
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
                                      fontSize: 24.00,
                                      color: colorId.white,
                                      // *text shadow here
                                      shadows: const [
                                        Shadow(
                                          blurRadius: 5.00,
                                          color: Color.fromARGB(
                                              248, 125, 156, 243),
                                          offset: Offset(5.0, 5.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: colorId.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40.00, right: 8.00, left: 8.00),
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
                                                shadows: const [
                                                  Shadow(
                                                    blurRadius: 5.00,
                                                    color: Color.fromARGB(
                                                        249, 26, 172, 41),
                                                    offset: Offset(5.0, 5.0),
                                                  ),
                                                ],
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
                                            shadows: const [
                                              Shadow(
                                                blurRadius: 5.00,
                                                color: Color.fromARGB(
                                                    255, 236, 97, 97),
                                                offset: Offset(5.0, 5.0),
                                              ),
                                            ],
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
              const SizedBox(
                height: 160.00,
                child: Carousel(),
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
                        await TransactionDB().refreshUiTransaction();
                        await CategoryDB.instance.refreshUI().then(
                              (value) => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const AllTransaction(),
                                ),
                              ),
                            );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 13.00),
                        child: Text(
                          'View all',
                          style: TextStyle(fontSize: 10.00),
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


