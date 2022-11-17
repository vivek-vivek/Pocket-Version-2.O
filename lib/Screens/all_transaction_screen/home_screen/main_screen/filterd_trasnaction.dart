// ignore_for_file: avoid_print, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:budgetory_v1/Screens/all_transaction_screen/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
    TextEditingController searchTextController = TextEditingController();
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
                  hintText: 'ex . food , salary')
              : const SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 25, left: 25),
                child: Container(
                  height: 30.00,
                  decoration: BoxDecoration(
                      color: colorId.btnColor,
                      borderRadius: BorderRadius.circular(20.00)),
                  child: Center(
                    child: DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: colorId.white,
                      ),
                      dropdownColor: colorId.btnColor,
                      borderRadius: BorderRadius.circular(20),
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
                                modalDummy =
                                    TransactionDB.instance.IncomeNotifier.value;
                              } else if (filterItemsArray ==
                                  filterArray.filterItemsArray[2]) {
                                modalDummy = TransactionDB
                                    .instance.expenceNotifier.value;
                              }
                            }),
                            value: filterItemsArray,
                            child: SizedBox(
                              height: 30.00,
                              width: 66.00,
                              child: Text(
                                filterItemsArray,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: colorId.white,
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
                padding: const EdgeInsets.only(right: 14.00, left: 5.00),
                child: Container(
                  height: 30.000,
                  decoration: BoxDecoration(
                      color: colorId.btnColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, top: 4),
                    child: DropdownButton(
                      icon: Icon(
                        Icons.filter_list,
                        color: colorId.white,
                      ),
                      dropdownColor: colorId.btnColor,
                      borderRadius: BorderRadius.circular(20),
                      elevation: 0,
                      isDense: true,
                      underline: const SizedBox(),
                      value: timeDropValue,
                      items: filterArray.timeDropList.map(
                        (String timeDropList) {
                          return DropdownMenuItem(
                            value: timeDropList,
                            child: SizedBox(
                              height: 40.00,
                              width: 60.00,
                              child: Text(
                                timeDropList,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: colorId.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        timeDropValue = value;

                        if (categoryDropValue ==
                            filterArray.filterItemsArray[0]) {
                          if (timeDropValue == filterArray.timeDropList[0]) {
                            setState(() {
                              modalDummy =
                                  Filter.instance.allTodayNotifier.value;
                            });
                          }
                          // ^month picker

                          else if (timeDropValue ==
                              filterArray.timeDropList[1]) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return SimpleDialog(
                                  children: [
                                    Container(
                                      width: 300.00,
                                      height: 234.00,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: GridView.builder(
                                        itemCount: filterArray.monthList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
                                        itemBuilder: (context, index) {
                                          final i = index;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: colorId.btnColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: TextButton(
                                                onPressed: () async {
                                                  setState(
                                                    () {
                                                      try {
                                                        final customMonth =
                                                            filterArray
                                                                .newMonthList[i];
                                                        Filter.instance
                                                            .filterTransactionFunction(
                                                                customMonth:
                                                                    customMonth);
                                                        modalDummy = Filter
                                                            .instance
                                                            .allMonthlyNotifier
                                                            .value;
                                                      } catch (e) {
                                                        print(
                                                            "🚫 in  month choosing \n $e");
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
                                                        fontWeight:
                                                            FontWeight.bold),
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
                          } else if (timeDropValue ==
                              filterArray.timeDropList[2]) {
                            Filter.instance.customDateAll(context: context);
                            setState(() {
                              modalDummy =
                                  Filter.instance.allDateRangeNotifier.value;
                            });
                          }
                        }
                        // ^income
                        else if (categoryDropValue ==
                            filterArray.filterItemsArray[1]) {
                          if (timeDropValue == filterArray.timeDropList[0]) {
                            setState(() {
                              modalDummy =
                                  Filter.instance.incomeTodayNotifier.value;
                            });
                          } else if (timeDropValue ==
                              filterArray.timeDropList[1]) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return SimpleDialog(
                                  // ^tittle - simple dialog,selected month
                                  title: Text(
                                    DateFormat.yMMMM()
                                        .format(DateTime(DateTime.now().year)),
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: colorId.btnColor,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  children: [
                                    Container(
                                      width: 300.00,
                                      height: 234.00,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: GridView.builder(
                                        itemCount: filterArray.monthList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
                                        itemBuilder: (context, index) {
                                          final i = index;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: colorId.btnColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: TextButton(
                                                onPressed: () async {
                                                  setState(
                                                    () {
                                                      try {
                                                        final customMonth =
                                                            filterArray
                                                                .newMonthList[i];
                                                        Filter.instance
                                                            .filterTransactionFunction(
                                                                customMonth:
                                                                    customMonth);

                                                        print({customMonth, i});
                                                        print(customMonth);
                                                        print(modalDummy);
                                                        modalDummy = Filter
                                                            .instance
                                                            .incomeMonthlyNotifier
                                                            .value;
                                                      } catch (e) {
                                                        print(
                                                            "🚫 in  month choosing \n $e");
                                                      } finally {
                                                        Navigator.of(context)
                                                            .pop();
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
                                                        fontWeight:
                                                            FontWeight.bold),
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
                          } else if (timeDropValue ==
                              filterArray.timeDropList[2]) {
                            Filter.instance.customDateAll(context: context);
                            setState(() {
                              modalDummy =
                                  Filter.instance.incomeDateRangeNotifier.value;
                            });
                          }
                        }
                        // ^Expence
                        else if (categoryDropValue ==
                            filterArray.filterItemsArray[2]) {
                          if (timeDropValue == filterArray.timeDropList[0]) {
                            setState(() {
                              modalDummy =
                                  Filter.instance.expenceTodayNotifier.value;
                            });
                          } else if (timeDropValue ==
                              filterArray.timeDropList[1]) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return SimpleDialog(
                                  // ^tittle - simple dialog,selected month
                                  title: Text(
                                    DateFormat.yMMMM()
                                        .format(DateTime(DateTime.now().year)),
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: colorId.btnColor,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  children: [
                                    Container(
                                      width: 300.00,
                                      height: 234.00,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: GridView.builder(
                                        itemCount: filterArray.monthList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
                                        itemBuilder: (context, index) {
                                          final i = index;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: colorId.btnColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: TextButton(
                                                onPressed: () async {
                                                  setState(
                                                    () {
                                                      final customMonth =
                                                          filterArray
                                                              .newMonthList[i];
                                                      Filter.instance
                                                          .filterTransactionFunction(
                                                              customMonth:
                                                                  customMonth);

                                                      modalDummy = Filter
                                                          .instance
                                                          .expenceMonthlyNotifier
                                                          .value;
                                                    },
                                                  );
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text(
                                                  filterArray.monthList[index],
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        color: colorId.white,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                          } else if (timeDropValue ==
                              filterArray.timeDropList[2]) {
                            Filter.instance.customDateAll(context: context);
                            setState(() {
                              modalDummy = Filter
                                  .instance.expenceDateRangeNotifier.value;
                            });
                          }
                        }
                      },
                    ),
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
                        itemCount: modalDummy.length,
                        itemBuilder: (context, index) {
                          final newValue = modalDummy[index];

                          return Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(80.000),
                                      ),
                                      color: colorId.white,
                                    ),
                                    child: ListTile(
                                      key: Key(newValue.id!),
                                      onLongPress: () {
                                        try {
                                          TransactionDB.instance
                                              .deleteTransaction(newValue.id!);
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
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
                                  const SizedBox(height: 10.000)
                                ],
                              ),
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

  //search

}
