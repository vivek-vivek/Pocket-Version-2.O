// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:budgetory_v1/DB/transaction_db_f.dart';
import 'package:flutter/material.dart';
import '../DB/category_db_f.dart';
import '../DataBase/Models/ModalCategory/category_model.dart';
import '../DataBase/Models/ModalTransaction/transaction_modal.dart';

class Filter {
  Filter._internal();
  static Filter instance = Filter._internal();
  factory Filter() {
    return instance;
  }
  //  ~  DB name
  // ignore: constant_identifier_names
  static const TransactionDBName = 'Transaction DB Name';

  // ~*notifiers - time-- with Category-Income
  ValueNotifier<List<TransactionModal>> incomeTodayNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> incomeWeeklyNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> incomeMonthlyNotifier =
      ValueNotifier([]);

  // * notifiers - time-- with Category-Income
  ValueNotifier<List<TransactionModal>> expenceTodayNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> expenceWeeklyNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> expenceMonthlyNotifier =
      ValueNotifier([]);
  // * notifiers - time-- with Category-all
  ValueNotifier<List<TransactionModal>> allTodayNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> allWeeklyNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> allMonthlyNotifier = ValueNotifier([]);

  // ~ get filter functions
  filterCall() async {
    incomeTodayNotifier.value.clear();
    incomeWeeklyNotifier.value.clear();
    incomeMonthlyNotifier.value.clear();
    expenceTodayNotifier.value.clear();
    expenceWeeklyNotifier.value.clear();
    expenceMonthlyNotifier.value.clear();
    allTodayNotifier.value.clear();
    allWeeklyNotifier.value.clear();
    allMonthlyNotifier.value.clear();
  }

  // ~ notifiers - time with Category-income  function
  filterTransactionFunction() async {
    // ?clear all notifiers

    // ?refreshing
    final dbItems = await TransactionDB.instance.getTransactions();
    // dbItems.sort((first, second) => second.date.compareTo(first.date));
    // TransactionDB.instance.transactionListNotifier.value.clear();
    // await CategoryDB.instance.refreshUI();
    // TransactionDB.instance.transactionListNotifier.value.addAll(dbItems);
    // TransactionDB.instance.transactionListNotifier.notifyListeners();
    await TransactionDB.instance.refreshUiTransaction();

    Future.forEach(dbItems, (TransactionModal modalTransaction) {
      // ~ All

      // ~ income
      if (modalTransaction.type == CategoryType.income &&
          modalTransaction.date ==
              (DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day))) {
        incomeTodayNotifier.value.clear();
        incomeTodayNotifier.value.add(modalTransaction);
        incomeTodayNotifier.notifyListeners();
      }
      // ~weekly
      else if (modalTransaction.type == CategoryType.income &&
          modalTransaction.date == (DateTime(DateTime.now().day - 7))) {
        incomeWeeklyNotifier.value.clear();
        incomeWeeklyNotifier.value.add(modalTransaction);
        incomeWeeklyNotifier.notifyListeners();
      }
      // ~ monthly
      else if (modalTransaction.type == CategoryType.income &&
          modalTransaction.date.month == DateTime.now().month) {
        incomeMonthlyNotifier.value.clear();
        incomeMonthlyNotifier.value.add(modalTransaction);
        incomeMonthlyNotifier.notifyListeners();
      }
      // ~ expence
      else if (modalTransaction.date ==
              (DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day)) &&
          modalTransaction.type == CategoryType.expense) {
        expenceTodayNotifier.value.clear();
        expenceTodayNotifier.value.add(modalTransaction);
        expenceTodayNotifier.notifyListeners();
      }
      // ~weekly
      else if (modalTransaction.date == (DateTime(DateTime.now().day - 7)) &&
          modalTransaction.type == CategoryType.expense) {
        expenceWeeklyNotifier.value.clear();
        expenceWeeklyNotifier.value.add(modalTransaction);
        expenceWeeklyNotifier.notifyListeners();
      }
      // ~ monthly
      else if (modalTransaction.date.month == DateTime.now().month &&
          modalTransaction.type == CategoryType.expense) {
        expenceMonthlyNotifier.value.clear();
        expenceMonthlyNotifier.value.add(modalTransaction);
        expenceMonthlyNotifier.notifyListeners();
      } else if (modalTransaction.date ==
          (DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
        allTodayNotifier.value.clear();
        allTodayNotifier.value.add(modalTransaction);
        allTodayNotifier.notifyListeners();
      }
      // ~weekly
      else if (modalTransaction.date == (DateTime(DateTime.now().day - 7))) {
        allWeeklyNotifier.value.clear();
        allWeeklyNotifier.value.add(modalTransaction);
        allWeeklyNotifier.notifyListeners();
      }
      // ~ monthly
      if (modalTransaction.date.month == DateTime.now().month) {
        allMonthlyNotifier.value.clear();
        allMonthlyNotifier.value.add(modalTransaction);
        allMonthlyNotifier.notifyListeners();
      }
    });
  }
}
