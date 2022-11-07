import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../DB/Transactions/transaction_db_f.dart';
import '../../../DataBase/Models/ModalCategory/category_model.dart';
import '../../../colors/color.dart';

class Filtered {
  // colorID is class that contain all colors
  final colorId = ColorsID();

  // helps to create filtered list transaction category tile
  filter({required newList, required categoryDropValue}) {
    if (categoryDropValue == "All") {
      //* All
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final newValue = newList[index];

          return Slidable(
            key: Key(newValue.id),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    try {
                      TransactionDB.instance.deleteTransaction(newValue.id);
                    } catch (e) {
                      print('Exception🚫🚫🚫🚫 \n $e');
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
                    subtitle: Text(DateFormat.yMMMMd().format(newValue.date)),
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
    else if (categoryDropValue == 'Income') {
      // *Income==Income
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
    }
    //^---------------------------------------------------------------------------------------------------------
    else {
      // *expence
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
}
