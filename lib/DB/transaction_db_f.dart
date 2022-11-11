// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_print

import 'package:budgetory_v1/DB/category_db_f.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const transactionDBName = 'Transaction DB Name';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModal obj);
  Future<void> amountTransaction(TransactionDbAmount obj);
  Future<List<TransactionModal>> getTransactions();
}

class TransactionDB implements TransactionDbFunctions {
  // ^-------------------------Value Notifiers------------------------------------------
  //~ transaction notifier
  ValueNotifier<List<TransactionModal>> transactionListNotifier =
      ValueNotifier([]);
  // ~ notifiers - category
  ValueNotifier<List<TransactionModal>> IncomeNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> expenceNotifier = ValueNotifier([]);

  // ~notifiers - Time
  ValueNotifier<List<TransactionModal>> todayNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> MonthlyNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> weeklyNotifier = ValueNotifier([]);
  // ~ notifiers - time with Category
  ValueNotifier<List<TransactionModal>> todayAllNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> todayIncomeNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> todayExpenceNotifier =
      ValueNotifier([]);

  // ^-------------------------------------end------------------------------------------

  // ^----------------------------------instance----------------------------------------

  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }
  // ^---------------------------------end----------------------------------------------

  //^-----------------------------Add Transaction---------------------------------------

  //~ adding transaction function
  @override
  Future<void> addTransaction(TransactionModal obj) async {
    final transDb = await Hive.openBox<TransactionModal>(transactionDBName);
    transDb.put(obj.id, obj);
  }

  //^---------------------------------------End------------------------------------------

  //^-----------------------------Get Transaction----------------------------------------

  // ~ getting transaction from somewhere
  @override
  Future<List<TransactionModal>> getTransactions() async {
    print("❤️❤️");
    final transDb = await Hive.openBox<TransactionModal>(transactionDBName);
    print(transDb.values.toList());
    return transDb.values.toList();
  }

  // ~ getting Amount from AmountDb
  Future<List<TransactionDbAmount>> getAmount() async {
    print("❤️❤️");
    final DB = await Hive.openBox<TransactionDbAmount>(transactionDBName);
    print(DB.values.toList());
    return DB.values.toList();
  }
  //^----------------------------------end ----------------------------------------------

  //^ -------------------------------Refreshing UI------------------------------------------
  // ~refreshing UI-->f
  Future<void> refreshUiTransaction() async {
    final list = await getTransactions();
    // final amt = await getAmount();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    CategoryDB.instance.refreshUI();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();

    //~today filter
    todayNotifier.value.clear();
    Future.forEach(
      list,
      (TransactionModal modalTransaction) {
        // ~ today
        if (modalTransaction.date ==
            (DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day))) {
          todayNotifier.value.add(modalTransaction);
          todayNotifier.notifyListeners();
        }
        // ~weekly
        else if (modalTransaction.date == (DateTime(DateTime.now().day - 7))) {
          weeklyNotifier.value.add(modalTransaction);
          weeklyNotifier.notifyListeners();
        }
        // ~ monthly
        else if (modalTransaction.date.month == DateTime.now().month) {
          MonthlyNotifier.value.add(modalTransaction);
          MonthlyNotifier.notifyListeners();
        }
      },
    );

    //~weekly filter
    Future.forEach(
      list,
      (TransactionModal modalTransaction) {
        if (modalTransaction.date == (DateTime(DateTime.now().day - 7))) {
          weeklyNotifier.value.add(modalTransaction);
          weeklyNotifier.notifyListeners();
        }
      },
    );
    //~monthly filter
    MonthlyNotifier.value.clear();
    Future.forEach(
      list,
      (TransactionModal modalTransaction) {
        if (modalTransaction.date.month == DateTime.now().month) {
          MonthlyNotifier.value.add(modalTransaction);
          MonthlyNotifier.notifyListeners();
        }
      },
    );

    // ~income & expence  drop
    expenceNotifier.value.clear();
    IncomeNotifier.value.clear();
    Future.forEach(
      list,
      (TransactionModal modalTransaction) {
        if (modalTransaction.type == CategoryType.income) {
          IncomeNotifier.value.add(modalTransaction);
          IncomeNotifier.notifyListeners();
        } else {
          expenceNotifier.value.add(modalTransaction);
          expenceNotifier.notifyListeners();
        }
        todayNotifier.notifyListeners();
        weeklyNotifier.notifyListeners();
        MonthlyNotifier.notifyListeners();
      },
    );

    // ~ notifiers - time with Category-income  function
    todayIncomeNotifier.value.clear();
  }

  // ^------------------------------------end-----------------------------------------------

  //^-----------------------------Total amount Of Income & TransactionDB--------------------

  //  finding total amount of income form transaction db
  List totalTransaction() {
    int total = 0;
    int _income = 0;
    int _expences = 0;
    for (var i = 0; i < transactionListNotifier.value.length; i++) {
      late final newValue = transactionListNotifier.value[i];
      if (newValue.type == CategoryType.income) {
        _income = newValue.amount.toInt() + _income.toInt();
      } else {
        _expences = newValue.amount.toInt() + _expences.toInt();
      }
      total = _income - _expences;
    }

    // total amount
    return [total, _income, _expences];
  }

  //^-----------------------------------------end-------------------------------------------

  //^-----------------------------------Delete Transaction-------------------------------------

  //  ! delete a transaction -fnt  ------------> not working ???
  //  !  it helps to delete a transaction form db,
  //  !using transaction Id

  Future deleteTransaction(DateTime id) async {
    final newList = await Hive.openBox<TransactionModal>('transactionDb');
    await newList.delete(id);
    await refreshUiTransaction();
    print("🤍");
  }

  // ^-----------------------------------------------end---------------------------------------------

  // ^---------------------------------------Delete Transaction DB all-----------------------------

  Future<void> deleteDBAll() async {
    final _transactionDb =
        await Hive.openBox<TransactionModal>(transactionDBName);
    _transactionDb.clear();
    await refreshUiTransaction();
  }

  @override
  Future<void> amountTransaction(TransactionDbAmount obj) async {
    final transDb = await Hive.openBox<TransactionDbAmount>(transactionDBName);
    transDb.put(obj.id, obj);
  }

  // ^------------------------------------------------end------------------------------------------

}
