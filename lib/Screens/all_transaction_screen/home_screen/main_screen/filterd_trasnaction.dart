// ignore_for_file: avoid_print, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:budgetory_v1/screens/all_transaction_screen/widgets/edit.dart';
import 'package:budgetory_v1/screens/all_transaction_screen/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';
import '../../../../DB/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalCategory/category_model.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';
import '../../../../controller/filter_array.dart';
import '../../../../controller/filter_controller.dart';
import '../../widgets/pop_up_transaction.dart';

final GlobalKey<ScaffoldState> newContext = GlobalKey<ScaffoldState>();

class AllTransactionsNew extends StatefulWidget {
  const AllTransactionsNew({super.key});
  @override
  State<AllTransactionsNew> createState() => _AllTransactionsNewState();
}

class _AllTransactionsNewState extends State<AllTransactionsNew> {
  String? categoryDropValue;
  String? timeDropValue;
  List<TransactionModal> modalDummy = [];

  // String? customMonth;
  @override
  void initState() {
    modalDummy = TransactionDB.instance.transactionListNotifier.value;
    TransactionDB.instance.refreshUiTransaction();
    // initial custom month -- current month
    // customMonth = DateTime(DateTime.now().month);
    Filter.instance.filterTransactionFunction(customMonth: null);
    categoryDropValue = 'All';
    timeDropValue = 'Today';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUiTransaction();

    final searchTextEditingController = TextEditingController();
    return Scaffold(
      key: newContext,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorId.black),
        backgroundColor: colorId.white,
        elevation: 0,
        title: Text(
          'Transactions',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: colorId.btnColor, fontWeight: FontWeight.bold)),
        ),
      ),
      body: Column(
        children: [
          (categoryDropValue == filterArray.filterItemsArray[0]
              ? SearchWidget(
                  text: searchTextEditingController.text,
                  onChanged: (text) async {
                    print(text);
                    await Filter.instance.searchWord(controlText: text);
                    setState(() {
                      modalDummy = Filter.instance.searchNotifier.value;
                    });
                  },
                  hintText: 'search')
              : const SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 10, right: 25, left: 40),
                child: Container(
                  height: 30.00,
                  decoration: BoxDecoration(
                    color: colorId.btnColor,
                  ),
                  child: SizedBox(
                    width: 80,
                    child: DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: colorId.white,
                        size: 15,
                      ),
                      dropdownColor: colorId.btnColor,
                      // borderRadius: BorderRadius.circular(20),
                      elevation: 0,
                      isDense: true,
                      underline: const SizedBox(),
                      value: categoryDropValue,
                      items: filterArray.filterItemsArray.map(
                        (String filterItemsArray) {
                          return DropdownMenuItem(
                            onTap: (() async {
                              await TransactionDB.instance
                                  .refreshUiTransaction();

                              // All - ALL
                              if (filterItemsArray ==
                                  filterArray.filterItemsArray[0]) {
                                modalDummy = TransactionDB
                                    .instance.transactionListNotifier.value;
                                print("🥵 $DateTime");
                              } else if (filterItemsArray ==
                                  filterArray.filterItemsArray[1]) {
                                modalDummy = TransactionDB
                                    .instance.IncomeNotifier.value;
                              } else if (filterItemsArray ==
                                  filterArray.filterItemsArray[2]) {
                                modalDummy = TransactionDB
                                    .instance.expenceNotifier.value;
                              }
                            }),
                            value: filterItemsArray,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                filterItemsArray,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: colorId.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            categoryDropValue = value;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 45,bottom: 10),
                child: SizedBox(
                  height: 30,
                  width: 80.00,
                  child: PlutoMenuBar(
                    backgroundColor: colorId.btnColor,
                    activatedColor: colorId.lightGreen,
                    indicatorColor: Colors.deepOrange,
                    textStyle: const TextStyle(color: Colors.white),
                    menuIconColor: Colors.white,
                    moreIconColor: Colors.white,
                    menus: getMenus(context),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext context, List<TransactionModal> newList,
                  Widget? _) {
                return modalDummy.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                                image: AssetImage('Assets/empty1.jpeg')),
                            Text(
                              "No Transactions Found",
                              style: TextStyle(color: colorId.veryLightGrey),
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: modalDummy.length,
                        itemBuilder: (context, index) {
                          final newValue = modalDummy[index];
                          return Column(
                            children: [
                              Slidable(
                                key: Key(newValue.id!),
                                startActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (key) {
                                          try {
                                            print("🫡going to delete function");
                                            print("🤍${newValue.id}");
                                            TransactionDB.instance
                                                .deleteTransaction(
                                                    newValue.id!);
                                          } catch (e) {
                                            print("ERROR\n$e");
                                          }
                                        },
                                        icon: Icons.delete,
                                        backgroundColor: colorId.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      SlidableAction(
                                        backgroundColor: colorId.lightBlue,
                                        borderRadius: BorderRadius.circular(20),
                                        onPressed: (v) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => EditScreen(
                                                index: index,
                                                transactionModal: newValue,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icons.edit,
                                      ),
                                    ]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(80.000),
                                    ),
                                    color: colorId.white,
                                  ),
                                  child: ListTile(
                                    onLongPress: () {},
                                    onTap: () {
                                      popTransaction.popUpTransactionDetalies(
                                          context: context,
                                          notes: newValue.notes,
                                          category: newValue.type,
                                          date: newValue.date,
                                          amount: newValue.amount);
                                    },
                                    leading: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: newValue.type ==
                                                CategoryType.expense
                                            ? colorId.lightRed
                                            : colorId.lightGreen,
                                      ),
                                    ),
                                    title: Text(newValue.notes),
                                    subtitle: Text(DateFormat.yMMMMd()
                                        .format(newValue.date)),
                                    trailing: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.00),
                                      child: Text(
                                        newValue.amount.toString(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.000)
                            ],
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

// ^------------------------------------------------------------------------------------------------------------------------
// ~-------------------------------------------------------------class Objects----------------------------------------------
  final filterArray = FilterArray();
  final colorId = ColorsID();
  final popTransaction = PopUpTransaction();

// ~-------------------------------------------------------------------End--------------------------------------------------

  List<PlutoMenuItem> getMenus(BuildContext context) {
    return [
      PlutoMenuItem(
        title: 'Filter',
        icon: Icons.keyboard_arrow_down,
        children: [
          // ? All filtration
          // ?  - All      Category
          // ?  - Income   Category
          // ?  - Expence  Category
          PlutoMenuItem(
              title: 'All',
              onTap: () {
                if (categoryDropValue == filterArray.filterItemsArray[0]) {
                  if (timeDropValue == filterArray.timeDropList[0]) {
                    setState(() {
                      modalDummy =
                          TransactionDB.instance.transactionListNotifier.value;
                    });
                  }
                } else if (categoryDropValue ==
                    filterArray.filterItemsArray[1]) {
                  if (timeDropValue == filterArray.timeDropList[0]) {
                    setState(() {
                      modalDummy = TransactionDB.instance.IncomeNotifier.value;
                    });
                  }
                } else if (categoryDropValue ==
                    filterArray.filterItemsArray[2]) {
                  if (timeDropValue == filterArray.timeDropList[0]) {
                    setState(() {
                      modalDummy = TransactionDB.instance.expenceNotifier.value;
                    });
                  }
                }
              }),
          // ? today filtration
          // ?  - All      Category
          // ?  - Income   Category
          // ?  - Expence  Category
          PlutoMenuItem(
            title: 'Today',
            onTap: () {
              if (categoryDropValue == filterArray.filterItemsArray[0]) {
                if (timeDropValue == filterArray.timeDropList[0]) {
                  setState(() {
                    modalDummy = Filter.instance.allTodayNotifier.value;
                  });
                }
              } else if (categoryDropValue == filterArray.filterItemsArray[1]) {
                if (timeDropValue == filterArray.timeDropList[0]) {
                  setState(() {
                    modalDummy = Filter.instance.incomeTodayNotifier.value;
                  });
                }
              } else if (categoryDropValue == filterArray.filterItemsArray[2]) {
                if (timeDropValue == filterArray.timeDropList[0]) {
                  setState(() {
                    modalDummy = Filter.instance.expenceTodayNotifier.value;
                  });
                }
              }
            },
          ),
          PlutoMenuItem(title: 'Monthly', children: [
            PlutoMenuItem(
                title: 'January',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.january,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.january,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.january,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'February',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.february,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.february,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.february,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'March',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.march,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.march,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.march,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'April',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.april,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.april,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.april,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'May',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.may,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.may,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.may,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'June',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.june,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.june,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.june,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'July',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.july,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.july,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.july,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'August',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.august,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.august,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.august,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'September',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.september,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.september,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.september,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'October',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.october,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.october,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.october,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'November',
                onTap: () async {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.november,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.november,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.november,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
            PlutoMenuItem(
                title: 'December',
                onTap: () {
                  if (categoryDropValue == filterArray.filterItemsArray[0]) {
                    monthlyFilter(
                        month: DateTime.december,
                        notifier: Filter.instance.allMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[1]) {
                    monthlyFilter(
                        month: DateTime.december,
                        notifier: Filter.instance.incomeMonthlyNotifier.value);
                  } else if (categoryDropValue ==
                      filterArray.filterItemsArray[2]) {
                    monthlyFilter(
                        month: DateTime.december,
                        notifier: Filter.instance.expenceMonthlyNotifier.value);
                  }
                }),
          ])
        ],
      ),

      // ? Monthly filtration
      // ?  - All      Category
      // ?  - Income   Category
      // ?  - Expence  Category
    ];
  }

  Future monthlyFilter({required month, required notifier}) async {
    setState(
      () {
        final customMonth = month;
        Filter.instance.filterTransactionFunction(customMonth: customMonth);
        modalDummy = notifier;
      },
    );
  }

  Future monthPopUpDialog({required notifier}) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          // ^tittle - simple dialog,selected month
          title: Text(
            DateFormat.yMMMM().format(DateTime(DateTime.now().year)),
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: colorId.btnColor, fontWeight: FontWeight.bold)),
          ),
          children: [
            Container(
              width: 300.00,
              height: 234.00,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: GridView.builder(
                itemCount: filterArray.monthList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  final i = index;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: colorId.btnColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () async {
                          setState(
                            () {
                              try {
                                final customMonth = filterArray.newMonthList[i];
                                Filter.instance.filterTransactionFunction(
                                    customMonth: customMonth);

                                print({customMonth, i});
                                print(customMonth);
                                print(modalDummy);
                                modalDummy = notifier;
                              } catch (e) {
                                print("🚫 in  month choosing \n $e");
                              } finally {
                                Navigator.of(context).pop();
                              }
                            },
                          );
                          Navigator.of(ctx).pop();
                        },
                        child: Text(
                          filterArray.monthList[index],
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: colorId.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
