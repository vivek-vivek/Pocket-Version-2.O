// ignore_for_file: avoid_print, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:budgetory_v1/DB/category_db_f.dart';
import 'package:budgetory_v1/DB/transaction_db_f.dart';
import 'package:flutter/foundation.dart';
import '../DataBase/Models/ModalTransaction/transaction_modal.dart';

class MonthlyTransactionClass {
  MonthlyTransactionClass._internal();
  static MonthlyTransactionClass instance = MonthlyTransactionClass._internal();
  factory MonthlyTransactionClass() {
    return instance;
  }
  // ^--------------------Notifiers---------------------------
  ValueNotifier<List<TransactionModal>> monthlyTransactionNotifier =
      ValueNotifier([]);
  // ^------------------------end-----------------------------
  Future<void> refreshUiTransaction() async {
    final list = await TransactionDB.instance.getTransactions();

    // *sorting
    //* this line make code last  to first

    list.sort((first, second) => second.date.compareTo(first.date));
    TransactionDB.instance.transactionListNotifier.value.clear();
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.transactionListNotifier.value.addAll(list);
    TransactionDB.instance.transactionListNotifier.notifyListeners();
    Future.forEach(list, (TransactionModal modalTransaction) {
      if (modalTransaction.date ==
          (DateTime(
              DateTime.now().year, DateTime.now().month))) {
        monthlyTransactionNotifier.value.add(modalTransaction);
      }
    });
  }


}
