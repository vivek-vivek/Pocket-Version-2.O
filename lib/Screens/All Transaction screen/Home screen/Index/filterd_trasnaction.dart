// ignore_for_file: avoid_print

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
          children: [
            SizedBox(
              width: 150.00,
              child: Text(
                dropDownValue.toString(),
                style: TextStyle(color: colorId.black),
              ),
            ),
            DropdownButton(
              elevation: 0,
              isDense: true,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down_circle_outlined),
              // hint: const Text('Filter'),
              // value: dropDownValue,
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
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext context, List<TransactionModal> newList,
                  Widget? _) {
                return newList.isEmpty
                    ? Image.network(
                        'https://media0.giphy.com/media/Z9ErMP3gYYlcAadEGd/giphy.gif?cid=6c09b952bdf878b6c38ad34916bd84a3849dc23a1209b9b6&rid=giphy.gif&ct=g',
                        fit: BoxFit.fill,
                      )
                    : filter(newList);
              },
            ),
          ),
        ],
      ),
    );
  }

// ^-------------------------------------------------------------------------------------------------------
  filter(newList) {
    if (dropDownValue == "All") {
      return ListView.builder(
        shrinkWrap: true,
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
                        radius: 10,
                        backgroundColor: newValue.type == CategoryType.expense
                            ? colorId.lightRed
                            : colorId.lightGreen,
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
        shrinkWrap: true,
        itemCount: newList.length,
        itemBuilder: (context, index) {
          final newValue = newList[index];
          return newValue.type == CategoryType.income
              ? ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 10,
                        backgroundColor: newValue.type == CategoryType.expense
                            ? colorId.lightRed
                            : colorId.lightGreen),
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
        shrinkWrap: true,
        itemCount: newList.length,
        itemBuilder: (context, index) {
          final newValue = newList[index];
          return newValue.type == CategoryType.expense
              ? ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 10,
                        backgroundColor: newValue.type == CategoryType.expense
                            ? colorId.lightRed
                            : colorId.lightGreen),
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
