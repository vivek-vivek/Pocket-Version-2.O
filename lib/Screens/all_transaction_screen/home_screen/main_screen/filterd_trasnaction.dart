// ignore_for_file: avoid_print

import 'package:budgetory_v1/controller/filter_controller.dart';
import 'package:budgetory_v1/Screens/all_transaction_screen/widgets/category_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../../DB/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalCategory/category_model.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';
import '../../widgets/filter_array.dart';

class AllTransactionsNew extends StatefulWidget {
  const AllTransactionsNew({super.key});
  @override
  State<AllTransactionsNew> createState() => _AllTransactionsNewState();
}

class _AllTransactionsNewState extends State<AllTransactionsNew> {
  String? categoryDropValue;
  String? timeDropValue;
  List<TransactionModal> modalDummy = [];
  @override
  void initState() {
    Filter.instance.filterTransactionFunction();
    modalDummy = TransactionDB.instance.transactionListNotifier.value;
    categoryDropValue = 'All';
    timeDropValue = 'Today';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Filter.instance.filterTransactionFunction();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorId.black),
        backgroundColor: colorId.white,
        elevation: 0,
        title: Text(
          'Transactions',
          style: TextStyle(color: colorId.black),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.000),
                child: DropdownButton(
                  dropdownColor: colorId.lightBlue,
                  elevation: 0,
                  isDense: true,
                  underline: const SizedBox(),
                  value: categoryDropValue,
                  items: filterArray.filterItemsArray.map(
                    (String filterItemsArray) {
                      return DropdownMenuItem(
                        onTap: (() {
                          if (filterItemsArray ==
                              filterArray.filterItemsArray[0]) {
                            modalDummy = TransactionDB
                                .instance.transactionListNotifier.value;
                          } else if (filterItemsArray ==
                              filterArray.filterItemsArray[1]) {
                            modalDummy =
                                TransactionDB.instance.IncomeNotifier.value;
                          } else if (filterItemsArray ==
                              filterArray.filterItemsArray[2]) {
                            modalDummy =
                                TransactionDB.instance.expenceNotifier.value;
                          }
                        }),
                        value: filterItemsArray,
                        child: SizedBox(
                          height: 30.00,
                          width: 66.00,
                          child: Text(filterItemsArray),
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
              Padding(
                padding: const EdgeInsets.all(14.00),
                child: DropdownButton(
                  dropdownColor: colorId.lightBlue,
                  elevation: 0,
                  isDense: true,
                  underline: const SizedBox(),
                  value: timeDropValue,
                  items: filterArray.timeDropList.map(
                    (String timeDropList) {
                      return DropdownMenuItem(
                          value: timeDropList,
                          child: SizedBox(
                              height: 30.00,
                              width: 60.00,
                              child: Text(timeDropList)));
                    },
                  ).toList(),
                  onTap: () {
                    setState(
                      () {
                        Filter.instance.filterTransactionFunction();
                        if (categoryDropValue ==
                            filterArray.filterItemsArray[0]) {
                          if (timeDropValue == filterArray.timeDropList[0]) {
                            modalDummy = Filter.instance.allTodayNotifier.value;
                          } else if (timeDropValue ==
                              filterArray.timeDropList[1]) {
                            modalDummy =
                                Filter.instance.allWeeklyNotifier.value;
                          } else if (timeDropValue ==
                              filterArray.timeDropList[2]) {
                            modalDummy =
                                Filter.instance.allMonthlyNotifier.value;
                          }
                        }
                        // ^income
                        else if (categoryDropValue ==
                            filterArray.filterItemsArray[1]) {
                          if (timeDropValue == filterArray.timeDropList[0]) {
                            modalDummy =
                                Filter.instance.incomeTodayNotifier.value;
                          } else if (timeDropValue ==
                              filterArray.timeDropList[1]) {
                            modalDummy =
                                Filter.instance.incomeWeeklyNotifier.value;
                          } else if (timeDropValue ==
                              filterArray.timeDropList[2]) {
                            modalDummy =
                                Filter.instance.incomeMonthlyNotifier.value;
                          }
                        }
                        // ^Expence
                        else if (categoryDropValue ==
                            filterArray.filterItemsArray[2]) {
                          if (timeDropValue == filterArray.timeDropList[0]) {
                            modalDummy =
                                Filter.instance.expenceTodayNotifier.value;
                          } else if (timeDropValue ==
                              filterArray.timeDropList[1]) {
                            modalDummy =
                                Filter.instance.expenceWeeklyNotifier.value;
                          } else if (timeDropValue ==
                              filterArray.timeDropList[2]) {
                            modalDummy =
                                Filter.instance.expenceMonthlyNotifier.value;
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
            ],
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext context, List<TransactionModal> newList,
                  Widget? _) {
                return newList.isEmpty
                    ? const Center(
                        child: Image(image: AssetImage('Assets/empty.png')),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final newValue = modalDummy[index];

                          return Slidable(
                            key: Key(newValue.id!),
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    try {
                                      TransactionDB.instance
                                          .deleteTransaction(newValue);
                                    } catch (e) {
                                      print('Exception🚫🚫🚫🚫 \n $e');
                                    }
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
                                    trailing: Text(
                                      newValue.amount.toString(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.000)
                              ],
                            ),
                          );
                        },
                        itemCount: modalDummy.length,
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

// ^-------------------------------------------------------------------------------------------------------

  final filterCategory = Filtered();
  final filterArray = FilterArray();
  final colorId = ColorsID();
}
