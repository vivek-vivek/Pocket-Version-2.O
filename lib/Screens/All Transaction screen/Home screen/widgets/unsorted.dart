// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../../DB/Transactions/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';

class UnsortedTransaction extends StatefulWidget {
  const UnsortedTransaction({super.key});

  @override
  State<UnsortedTransaction> createState() => _UnsortedTransactionState();
}

class _UnsortedTransactionState extends State<UnsortedTransaction> {
  @override
  Widget build(BuildContext context) {
    // CategoryDB.instance.refreshUI();
    TransactionDB.instance.UnsortedTransactionsRefresher();
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder:
            (BuildContext context, List<TransactionModal> newList, Widget? _) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final newValue = newList[index];
              return Slidable(
                key: Key(newValue.id!),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        TransactionDB.instance.deleteTransaction(newValue.id!);
                      },
                      icon: Icons.delete,
                      foregroundColor: colorId.red,
                      backgroundColor: colorId.veryLightGrey,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(80.000),
                    ),
                    color: colorId.white,
                  ),
                  child: Card(
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: newValue.type == CategoryType.income
                              ? colorId.lightGreen
                              : colorId.lightRed,
                        ),
                      ),
                      subtitle: Text(DateFormat.yMMMMd().format(newValue.date)),
                      title: Text(newValue.notes),
                      trailing: Text(newValue.amount.toString()),
                    ),
                  ),
                ),
              );
            },
            itemCount: newList.length,
          );
        },
      ),
    );
  }

  final colorId = ColorsID();
}
