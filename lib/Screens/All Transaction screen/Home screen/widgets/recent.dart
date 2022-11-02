import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
                        TransactionDB.instance
                            .deleteTransaction(newValue.id!);
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
                      subtitle: Text(
                        DateFormat.MMMMEEEEd().format(newValue.date),
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
      },
    );
  }

  final colorId = ColorsID();
}
