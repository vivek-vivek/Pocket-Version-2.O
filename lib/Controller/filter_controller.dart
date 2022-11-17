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
  // *search - notes -notifier
  ValueNotifier<List<TransactionModal>> searchNotifier = ValueNotifier([]);

  // * notifiers - time-- with Category-all
  ValueNotifier<List<TransactionModal>> allTodayNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> allWeeklyNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> allMonthlyNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> allDateRangeNotifier =
      ValueNotifier([]);

  // ~*notifiers - time-- with Category-Income
  ValueNotifier<List<TransactionModal>> incomeTodayNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> incomeWeeklyNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> incomeMonthlyNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> incomeDateRangeNotifier =
      ValueNotifier([]);

  // * notifiers - time-- with Category-Expence
  ValueNotifier<List<TransactionModal>> expenceTodayNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> expenceWeeklyNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> expenceMonthlyNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModal>> expenceDateRangeNotifier =
      ValueNotifier([]);

  // ~ get filter functions
  notifiersCleaner() async {
    //  clear Notifier - search
    searchNotifier.value.clear();

    // clear Notifiers - All
    allTodayNotifier.value.clear();
    allWeeklyNotifier.value.clear();
    allMonthlyNotifier.value.clear();
    allDateRangeNotifier.value.clear();

    // clear Notifiers - Income
    incomeTodayNotifier.value.clear();
    incomeWeeklyNotifier.value.clear();
    incomeMonthlyNotifier.value.clear();
    incomeDateRangeNotifier.value.clear();

    // clear Notifiers - Expence
    expenceTodayNotifier.value.clear();
    expenceWeeklyNotifier.value.clear();
    expenceMonthlyNotifier.value.clear();
    expenceDateRangeNotifier.value.clear();
  }

  // ~ notifiers - time with Category-income  function
  filterTransactionFunction({customMonth}) async {
    // ?refreshing
    final getTransaction = await TransactionDB.instance.getTransactions();
    await TransactionDB.instance.refreshUiTransaction();
    //^clearing aal notifiers
    await notifiersCleaner();
    Future.forEach(
      getTransaction,
      (TransactionModal modalTransaction) {
        if (modalTransaction.date ==
            (DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day))) {
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
        if (modalTransaction.date.month == customMonth) {
          allMonthlyNotifier.value.add(modalTransaction);
          allMonthlyNotifier.notifyListeners();
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
      },
    );

    // custom date
  }

  DateTimeRange? dateRange = DateTimeRange(
    start: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
    end:
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );

  customDateAll({required context}) async {
    final getTransaction = await TransactionDB.instance.getTransactions();
    allDateRangeNotifier.value.clear();

    DateTimeRange? datePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (datePicked != null) {
      notifiersCleaner();
      TransactionDB.instance.refreshUiTransaction();
      Future.forEach(
        getTransaction,
        (TransactionModal modalTransaction) async {
          if (modalTransaction.type == CategoryType.income) {
            if (modalTransaction.date.isAfter(
                  datePicked.start.subtract(
                    const Duration(days: 1),
                  ),
                ) &&
                modalTransaction.date.isBefore(
                  datePicked.end.add(
                    const Duration(days: 1),
                  ),
                )) {
              await TransactionDB.instance.refreshUiTransaction();
              await filterTransactionFunction();
              incomeDateRangeNotifier.value.add(modalTransaction);
              incomeDateRangeNotifier.notifyListeners();
            }
          } else if (modalTransaction.type == CategoryType.expense) {
            if (modalTransaction.date.isAfter(
                  datePicked.start.subtract(
                    const Duration(days: 1),
                  ),
                ) &&
                modalTransaction.date.isBefore(
                  datePicked.end.add(
                    const Duration(days: 1),
                  ),
                )) {
              await TransactionDB.instance.refreshUiTransaction();
              await filterTransactionFunction();
              expenceDateRangeNotifier.value.add(modalTransaction);
              expenceDateRangeNotifier.notifyListeners();
            }
          }
          if (modalTransaction.date.isAfter(
                datePicked.start.subtract(
                  const Duration(days: 1),
                ),
              ) &&
              modalTransaction.date.isBefore(
                datePicked.end.add(
                  const Duration(days: 1),
                ),
              )) {
            await TransactionDB.instance.refreshUiTransaction();
            await filterTransactionFunction();
            allDateRangeNotifier.value.add(modalTransaction);
            allDateRangeNotifier.notifyListeners();
          }
        },
      );
    }
  }

  // search
  searchWord({required String controlText}) async {
    final getTransaction = await TransactionDB.instance.getTransactions();
    searchNotifier.value.clear();
    if (controlText.isNotEmpty) {
      Future.forEach(getTransaction, (TransactionModal modalTransaction) {
        if (modalTransaction.notes
            .toLowerCase()
            .contains(controlText.toLowerCase())) {
          searchNotifier.value.add(modalTransaction);
          searchNotifier.notifyListeners();
        }
      });
    }
  }

  // void runFilter(String enteredKeyword) {
  //   List<TransactionModal> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = transactions;
  //   } else {
  //     results = transactions
  //         .where(
  //           (user) => user.category.name.trim().toLowerCase().contains(
  //                 enteredKeyword.trim().toLowerCase(),
  //               ),
  //         )
  //         .toList();
  //   }
  //   setState(() {
  //     foundTransactions = results;
  //   });
  // }
}
