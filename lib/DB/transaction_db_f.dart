// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_print

import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const transactionDBName = 'Transaction DB Name';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModal obj);
  Future<List<TransactionModal>> getTransactions();
}

class TransactionDB implements TransactionDbFunctions {
  // ^-------------------------Value Notifiers------------------------------------------
  //~ amount Calculation notifier
  ValueNotifier<List<double>> totalListNotifier = ValueNotifier([]);
  ValueNotifier<List<double>> incomeTotalListNotifier = ValueNotifier([]);
  ValueNotifier<List<double>> expenceTotalListNotifier = ValueNotifier([]);

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
    // list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();

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
      },
    );

    // ~ notifiers - time with Category-income  function

    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
  }

  // ^------------------------------------end-----------------------------------------------

  //^-----------------------------Total amount Of Income & TransactionDB--------------------

  //  finding total amount of income form transaction db
  // double? T;
  // double? I;
  // double? E;
  List totalTransaction() {
    double total = 0;
    double _income = 0;
    double _expences = 0;
    for (var i = 0; i < transactionListNotifier.value.length; i++) {
      late final newValue = transactionListNotifier.value[i];
      if (newValue.type == CategoryType.income) {
        _income = newValue.amount + _income;
        // I = _income;
      } else {
        _expences = newValue.amount + _expences;
        // E = _expences;
      }

      total = _income - _expences;
      // T = total;
    }

    // total amount
    return [total, _income, _expences];
  }

  //^-----------------------------------------------end------------------------------------------

  //^-----------------------------------------Delete Transaction----------------------------------

  Future<void> deleteTransaction(String id) async {
    print("💖$id");
    final transactionDB =
        await Hive.openBox<TransactionModal>(transactionDBName);

    transactionDB.delete(id);
    print("💜$id");
    refreshUiTransaction();
    print("👍 delete function finished");
  }

  // ^---------------------------------------------end-------------------------------------------

  // ^-----------------------------------Delete Transaction DB all-------------------------------

  Future<void> deleteDBAll() async {
    // T = null;
    // I = null;
    // E = null;
    final _transactionDb =
        await Hive.openBox<TransactionModal>(transactionDBName);
    _transactionDb.clear();
  }

  // ^------------------------------------------------end------------------------------------------
  update(index, TransactionModal modalCategory) async {
    final _categoryDB = await Hive.openBox<TransactionModal>(transactionDBName);
    _categoryDB.putAt(index, modalCategory);
    refreshUiTransaction();
  }
}
