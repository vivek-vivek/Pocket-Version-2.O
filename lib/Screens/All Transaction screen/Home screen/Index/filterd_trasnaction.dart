// ignore_for_file: avoid_print

import 'package:budgetory_v1/Screens/All%20Transaction%20screen/widgets/category_filter.dart';
import 'package:flutter/material.dart';

import '../../../../DB/Transactions/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';
import '../../widgets/filter_array.dart';

class AllTransactionsNew extends StatefulWidget {
  const AllTransactionsNew({super.key});
  @override
  State<AllTransactionsNew> createState() => _AllTransactionsNewState();
}

class _AllTransactionsNewState extends State<AllTransactionsNew> {
  String? categoryDropValue;
  String? timeDropValue;

  @override
  void initState() {
    categoryDropValue = 'All';
    timeDropValue = 'Today';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorId.black),
        backgroundColor: colorId.white,
        elevation: 0,
        title: Text(
          'Transactions',
          style: TextStyle(color: colorId.black),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.000),
                child: DropdownButton(
                  dropdownColor: colorId.lightBlue,
                  elevation: 0,
                  isDense: true,
                  underline: const SizedBox(),
                  value: categoryDropValue,
                  items: filterArray.filterItemsArray.map(
                    (String filterItemsArray) {
                      return DropdownMenuItem(
                        value: filterItemsArray,
                        child: SizedBox(
                          height: 30.00,
                          width: 66.00,
                          child: Text(filterItemsArray),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    try {
                      setState(
                        () {
                          categoryDropValue = value;
                        },
                      );
                    } catch (e) {
                      print("Exception in stare management \n $e");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.00),
                child: DropdownButton(
                  dropdownColor: colorId.lightBlue,
                  elevation: 0,
                  isDense: true,
                  underline: const SizedBox(),
                  value: timeDropValue,
                  items: filterArray.timeDropList.map(
                    (String timeDropValue) {
                      return DropdownMenuItem(
                          value: timeDropValue,
                          child: SizedBox(
                              height: 30.00,
                              width: 60.00,
                              child: Text(timeDropValue)));
                    },
                  ).toList(),
                  onChanged: (value) {
                    try {
                      setState(
                        () {
                          timeDropValue = value;
                        },
                      );
                    } catch (e) {
                      print("Exception in stare management \n $e");
                    }
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext context, List<TransactionModal> newList,
                  Widget? _) {
                return newList.isEmpty
                    ? Image.network(
                        'https://media0.giphy.com/media/Z9ErMP3gYYlcAadEGd/giphy.gif?cid=6c09b952bdf878b6c38ad34916bd84a3849dc23a1209b9b6&rid=giphy.gif&ct=g',
                        fit: BoxFit.fill,
                      )
                    : filterCategory.filter(
                        newList: newList, categoryDropValue: categoryDropValue);
              },
            ),
          ),
        ],
      ),
    );
  }

// ^-------------------------------------------------------------------------------------------------------

  final filterCategory = Filtered();
  final filterArray = FilterArray();
  final colorId = ColorsID();
}
