import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../../DB/Transactions/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalCategory/category_model.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';
import '../../../Graph/widgets/filter_array.dart';

class AllTransactionsNew extends StatefulWidget {
  const AllTransactionsNew({super.key});
  @override
  State<AllTransactionsNew> createState() => _AllTransactionsNewState();
}

class _AllTransactionsNewState extends State<AllTransactionsNew> {
  String? dropDownValue;
  @override
  void initState() {
    dropDownValue = 'All';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorId.black),
        backgroundColor: colorId.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton(
              elevation: 0,
              isDense: true,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down_circle_outlined),
              hint: const Text('Filter'),
              value: dropDownValue,
              items:
                  filterArray.filterItemsArray.map((String filterItemsArray) {
                return DropdownMenuItem(
                  value: filterItemsArray,
                  child: Text(filterItemsArray),
                );
              }).toList(),
              onChanged: (value) {
                setState(
                  () {
                    dropDownValue = value;
                  },
                );
              },
              onTap: () {
                dropDownValue = dropDownValue;
              },
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder:
            (BuildContext context, List<TransactionModal> newList, Widget? _) {
          return filter(newList);
        },
      ),
    );
  }

// ^-------------------------------------------------------------------------------------------------------
  filter(newList) {
    if (dropDownValue == "All") {
      return ListView.builder(
        itemBuilder: (context, index) {
          final newValue = newList[index];
          return Slidable(
            key: Key(newValue.id!),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    try {
                      TransactionDB.instance.deleteTransaction(newValue.id!);
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icons.delete,
                  foregroundColor: colorId.red,
                  backgroundColor: colorId.veryLightGrey,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                        backgroundColor: newValue.type == CategoryType.income
                            ? colorId.lightGreen
                            : colorId.lightRed,
                      ),
                    ),
                    title: Text(newValue.notes),
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
        itemCount: newList.length,
      );
    }
//^----------------------------------------------------------------------------------------------------
    else if (dropDownValue == 'Income') {
      return ListView.builder(
        itemCount: newList.length,
        itemBuilder: (context, index) {
          final newValue = newList[index];
          return newValue.type == CategoryType.income
              ? ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: newValue.type == CategoryType.income
                          ? colorId.lightGreen
                          : colorId.lightRed,
                    ),
                  ),
                  title: Text(newValue.notes),
                  subtitle: Text(DateFormat.yMMMMd().format(newValue.date)),
                  trailing: Text(newValue.amount.toString()),
                )
              : const SizedBox();
        },
      );
    } else {
      return ListView.builder(
        itemCount: newList.length,
        itemBuilder: (context, index) {
          final newValue = newList[index];
          return newValue.type == CategoryType.expense
              ? ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: newValue.type == CategoryType.expense
                          ? colorId.lightRed
                          : colorId.lightGreen,
                    ),
                  ),
                  title: Text(newValue.notes),
                  subtitle: Text(DateFormat.yMMMMd().format(newValue.date)),
                  trailing: Text(newValue.amount.toString()),
                )
              : const SizedBox();
        },
      );
    }
  }

  final filterArray = FilterArray();
  final colorId = ColorsID();
}
