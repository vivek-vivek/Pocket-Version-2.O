// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/category_db_f.dart';
import 'package:budgetory_v1/DB/transaction_db_f.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

class PopUpTransaction {
  Future<void> popUpTransactionDetalies(
      {required BuildContext context, notes, category, date, amount}) async {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    CategoryDB.instance.refreshUI();

    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text("Detalies", style: TextStyle(color: colorId.btnColor)),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26.00),
              child: Column(
                children: [
                  Row(children: [Text('Notes       : $notes')]),
                  Row(children: [
                    Text(
                        "Category  : ${category == CategoryType.income ? "Income" : "Expence"}")
                  ]),
                  Row(children: [
                    Text("Date          : ${DateFormat.yMMMMd().format(date)}")
                  ]),
                  Row(children: [Text("amount    : $amount")]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("OK"))
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  final colorId = ColorsID();
}
