import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../DB/Transactions/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalCategory/category_model.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';

class RecentTransaction extends StatelessWidget {
  RecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUiTransaction();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder:
          (BuildContext context, List<TransactionModal> newList, Widget? _) {
        return ListView.builder(
          itemCount: newList.length,
          itemBuilder: (context, index) {
            final newValue = newList[index];
            return ListTile(
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
            );
          },
        );
      },
    );
  }

  final colorId = ColorsID();
}
