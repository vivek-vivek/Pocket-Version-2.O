// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:budgetory_v1/DB/transaction_db_f.dart';
import 'package:flutter/material.dart';
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
  ValueNotifier<List<TransactionModal>> dateRangeList = ValueNotifier([]);

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
  filterTransactionFunction({customMonth}) async {
    // ?refreshing
    final getTransaction = await TransactionDB.instance.getTransactions();
    await TransactionDB.instance.refreshUiTransaction();
    //^clearing aal notifiers
    await filterCall();
    Future.forEach(getTransaction, (TransactionModal modalTransaction) {
      if (modalTransaction.date ==
          (DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
        allTodayNotifier.value.add(modalTransaction);
        allTodayNotifier.notifyListeners();
      }
      // ~ income
      if (modalTransaction.type == CategoryType.income &&
          modalTransaction.date ==
              (DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day))) {
        incomeTodayNotifier.value.add(modalTransaction);
        incomeTodayNotifier.notifyListeners();
      }

      // ~ expence
      if (modalTransaction.date ==
              (DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day)) &&
          modalTransaction.type == CategoryType.expense) {
        expenceTodayNotifier.value.add(modalTransaction);
        expenceTodayNotifier.notifyListeners();
      }
      if (modalTransaction.type == CategoryType.income &&
          modalTransaction.date.month == customMonth) {
        print(customMonth);
        incomeMonthlyNotifier.value.add(modalTransaction);
        incomeMonthlyNotifier.notifyListeners();
      }
      if (modalTransaction.type == CategoryType.expense &&
          modalTransaction.date.month == customMonth) {
        print("🟢$customMonth");
        expenceMonthlyNotifier.value.add(modalTransaction);
        expenceMonthlyNotifier.notifyListeners();
      }
      if (modalTransaction.date.month == customMonth) {
        allMonthlyNotifier.value.add(modalTransaction);
        allMonthlyNotifier.notifyListeners();
      } else {
        return;
      }
    });

    // custom date
  }

  var dateRange = DateTimeRange(
    start: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
    end:
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );
  customDateAll({required context}) async {
    final getTransaction = await TransactionDB.instance.getTransactions();
    dateRangeList.value.clear();

    DateTimeRange? datePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (datePicked != null) {
      TransactionDB.instance.refreshUiTransaction();
      dateRangeList.value.clear();
      Future.forEach(
        getTransaction,
        (TransactionModal modalTransaction) async {
          if (modalTransaction.date.isAfter(
                datePicked.end.add(
                  const Duration(days: 1),
                ),
              ) &&
              modalTransaction.date.isAfter(
                datePicked.start.subtract(
                  const Duration(days: 1),
                ),
              )) {
            await TransactionDB.instance.refreshUiTransaction();
            await filterTransactionFunction();
            dateRangeList.value.add(modalTransaction);

            dateRangeList.notifyListeners();
            print("🍎${modalTransaction.notes}");
          }
        },
      );
    }
  }
}
