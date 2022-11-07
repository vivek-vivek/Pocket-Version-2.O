// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/FunctionsCategory/category_db_f.dart';
import 'package:budgetory_v1/DB/Transactions/transaction_db_f.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../DataBase/Models/ModalCategory/category_model.dart';
import '../DataBase/Models/ModalTransaction/transaction_modal.dart';

class TodayTransactionClass {
  TodayTransactionClass._internal();
  static TodayTransactionClass instance = TodayTransactionClass._internal();
  factory TodayTransactionClass() {
    return instance;
  }
  // ^--------------------Notifiers---------------------------
  ValueNotifier<List<TransactionModal>> todayTransactionNotifier =
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
              DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
        todayTransactionNotifier.value.add(modalTransaction);
      }
    });
  }

  Future<void> deleteDBAll() async {
    final _categoryDB =
        await Hive.openBox<TransactionModal>("CATEGORY_DB_NAME");
    _categoryDB.delete(_categoryDB);
    _categoryDB.clear();
  }
}