import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../DB/Transactions/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalCategory/category_model.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';

class IncomeAllTransaction extends StatelessWidget {
  IncomeAllTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    Expense.instance.refreshUiTransaction();
    return ValueListenableBuilder(
      valueListenable: Expense.instance.transactionListNotifier,
      builder:
          (BuildContext context, List<TransactionModal> newList, Widget? _) {
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
      },
    );
  }

  final colorId = ColorsID();
}
