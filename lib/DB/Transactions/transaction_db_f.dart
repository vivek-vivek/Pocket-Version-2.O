// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_print

import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const transactionDBName = 'transaction*Db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModal obj);
  Future<List<TransactionModal>> getTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDbFunctions {
  ValueNotifier<List<TransactionModal>> transactionListNotifier =
      ValueNotifier([]);

  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

// *adding transaction function

  @override
  Future<void> addTransaction(TransactionModal obj) async {
    final transDb = await Hive.openBox<TransactionModal>(transactionDBName);

    transDb.put(obj.id, obj);
  }

// * getting transaction from somewhere
  @override
  Future<List<TransactionModal>> getTransactions() async {
    final transDb = await Hive.openBox<TransactionModal>(transactionDBName);
    return transDb.values.toList();
  }

  // *refreshing UI-->f
  Future<void> refreshUiTransaction() async {
    final list = await getTransactions();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
    print('🟢🟢🟢🟢');
  }

  // * refresh Function for -->
  //* Transaction's ?unsorted all transaction

  Future<void> UnsortedTransactionsRefresher() async {
    final list = await getTransactions();
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
    print('🤍🤍🤍🤍(Unsorted transaction refresher)');
  }

  // * finding total amount of income form transaction db
  List totalTransaction() {
    double total = 0;
    double _income = 0;
    double _expences = 0;
    // ?-------------------------------------------------------------
    for (var i = 0; i < transactionListNotifier.value.length; i++) {
      late final newValue = transactionListNotifier.value[i];
      if (newValue.type == CategoryType.income) {
        _income = newValue.amount + _income;
      } else {
        _expences = newValue.amount + _expences;
      }
      if (_expences == 0 && _income >= 0) {
        total = _income;
      } else if (_expences >= 0 && _income == 0) {
        total = _expences;
      } else {
        total = _income - _expences;
      }
    }
    // ?-------------------------------------------------------------
    // ^total amount
    return [total, _income, _expences];
  }

// ! delete a transaction -fnt  ------------> not working ???
//  !  it helps to delete a transaction form db,
// !using transaction Id
  @override
  Future<void> deleteTransaction(String id) async {
    print(id);
    final _TransactionDB =
        await Hive.openBox<TransactionModal>('transactionDb');
    await _TransactionDB.delete(id);
    await refreshUiTransaction();
    UnsortedTransactionsRefresher();
  }

  Future<void> deleteDBAll() async {
    final _transactionDb =
        await Hive.openBox<TransactionModal>(transactionDBName);
    _transactionDb.clear();

    UnsortedTransactionsRefresher();
    refreshUiTransaction();
  }
}
