// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../DB/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalCategory/category_model.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';
import '../../../../controller/filter_array.dart';
import '../../../../controller/filter_controller.dart';
import '../../widgets/pop_up_transaction.dart';

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
    return Scaffold(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.000),
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
                        Icons.keyboard_arrow_down_outlined,
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
                      onTap: () async {
                        setState(
                          () {
                            //  All - Transactions - filter

                            if (categoryDropValue ==
                                filterArray.filterItemsArray[0]) {
                              // All - Transactions - filter - today
                              if (timeDropValue ==
                                  filterArray.timeDropList[0]) {
                                modalDummy =
                                    Filter.instance.allTodayNotifier.value;
                              }
                              // ^month picker
                              //  All - Transactions - filter - month
                              else if (timeDropValue ==
                                  filterArray.timeDropList[1]) {
                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return SimpleDialog(
                                      // ^tittle - simple dialog,selected month
                                      // title: Text(
                                      //   DateFormat.yMMMM().format(DateTime()),
                                      //   style: GoogleFonts.lato(
                                      //       textStyle: TextStyle(
                                      //           color: colorId.btnColor,
                                      //           fontWeight: FontWeight.bold)),
                                      // ),
                                      children: [
                                        Container(
                                          width: 300.00,
                                          height: 234.00,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: GridView.builder(
                                            itemCount:
                                                filterArray.monthList.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4),
                                            itemBuilder: (context, index) {
                                              final i = index;
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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

                                                            print({
                                                              customMonth,
                                                              i
                                                            });
                                                            print(customMonth);
                                                            print(modalDummy);
                                                            modalDummy = Filter
                                                                .instance
                                                                .allMonthlyNotifier
                                                                .value;
                                                          } catch (e) {
                                                            print(
                                                                "🚫 in  month choosing \n $e");
                                                          } finally {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                      );
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text(
                                                      filterArray
                                                          .monthList[index],
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            color:
                                                                colorId.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                  filterArray.timeDropList[2]) {}
                            }
                            // ^income
                            else if (categoryDropValue ==
                                filterArray.filterItemsArray[1]) {
                              if (timeDropValue ==
                                  filterArray.timeDropList[0]) {
                                modalDummy =
                                    Filter.instance.incomeTodayNotifier.value;
                              } else if (timeDropValue ==
                                  filterArray.timeDropList[1]) {
                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return SimpleDialog(
                                      // ^tittle - simple dialog,selected month
                                      title: Text(
                                        DateFormat.yMMMM().format(
                                            DateTime(DateTime.now().year)),
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
                                            itemCount:
                                                filterArray.monthList.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4),
                                            itemBuilder: (context, index) {
                                              final i = index;
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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

                                                            print({
                                                              customMonth,
                                                              i
                                                            });
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                      );
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text(
                                                      filterArray
                                                          .monthList[index],
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            color:
                                                                colorId.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                SfDateRangePicker();
                              }
                            }
                            // ^Expence
                            else if (categoryDropValue ==
                                filterArray.filterItemsArray[2]) {
                              if (timeDropValue ==
                                  filterArray.timeDropList[0]) {
                                modalDummy =
                                    Filter.instance.expenceTodayNotifier.value;
                              } else if (timeDropValue ==
                                  filterArray.timeDropList[1]) {
                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return SimpleDialog(
                                      // ^tittle - simple dialog,selected month
                                      title: Text(
                                        DateFormat.yMMMM().format(
                                            DateTime(DateTime.now().year)),
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
                                            itemCount:
                                                filterArray.monthList.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4),
                                            itemBuilder: (context, index) {
                                              final i = index;
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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

                                                            print({
                                                              customMonth,
                                                              i
                                                            });
                                                            print(customMonth);
                                                            print(modalDummy);
                                                            modalDummy = Filter
                                                                .instance
                                                                .expenceMonthlyNotifier
                                                                .value;
                                                          } catch (e) {
                                                            print(
                                                                "🚫 in  month choosing \n $e");
                                                          } finally {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                      );
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text(
                                                      filterArray
                                                          .monthList[index],
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            color:
                                                                colorId.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                modalDummy = Filter
                                    .instance.expenceMonthlyNotifier.value;
                              }
                            }
                          },
                        );
                      },
                      onChanged: (value) {
                        setState(() {
                          timeDropValue = value;
                        });
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
                              Slidable(
                                key: Key(newValue.id!),
                                endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (xtx) {
                                        setState(() {
                                          print("2nd id -$index");
                                          try {
                                            TransactionDB.instance
                                                .deleteTransaction(
                                                    newValue.id!);
                                          } catch (e) {
                                            print("🚫🚫🚫🚫 $e");
                                          }
                                        });
                                      },
                                      icon: Icons.delete,
                                      foregroundColor: colorId.red,
                                      backgroundColor: colorId.veryLightGrey,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(80.000),
                                        ),
                                        color: colorId.white,
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          popTransaction
                                              .popUpTransactionDetalies(
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
                                          padding: const EdgeInsets.only(
                                              right: 10.00),
                                          child: Text(
                                            newValue.amount.toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10.000)
                                  ],
                                ),
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
}
