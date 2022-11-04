import 'package:budgetory_v1/DB/Transactions/transaction_db_f.dart';
import 'package:budgetory_v1/Screens/All%20Transaction%20screen/Home%20screen/Index/filterd_trasnaction.dart';
import 'package:budgetory_v1/Screens/Graph/widgets/filter_array.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';

import '../../../DataBase/Models/ModalTransaction/transaction_modal.dart';

class AllGraphDetails extends StatefulWidget {
  const AllGraphDetails({super.key});

  @override
  State<AllGraphDetails> createState() => _AllGraphDetailsState();
}

class _AllGraphDetailsState extends State<AllGraphDetails> {
  String? dorpDownValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.00, left: 8.00, top: 8.00),
      child: Container(
        color: colorId.purple,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AllTransactionsNew(),
                        ),
                      );
                    },
                    child: const Text("View All")),
// ^DropDownButton
                DropdownButton(
                  hint: const Text('Filter'),
                  value: dorpDownValue,
                  items: filterArray.filterItemsArray
                      .map((String filterItemsArray) {
                    return DropdownMenuItem(
                      value: filterItemsArray,
                      child: Text(filterItemsArray),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dorpDownValue = value;
                    });
                  },
                )
              ],
            ),
            ValueListenableBuilder(
                valueListenable: TransactionDB.instance.transactionListNotifier,
                builder: (BuildContext context, List<TransactionModal> newList,
                    Widget? _) {
                  return Column(
                    children: [
                      const SizedBox(height: 30.0),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: colorId.lightGreen,
                            radius: 6.00,
                          ),
                        ),
                        title: const Text('Income'),
                        trailing: Text(TransactionDB.instance
                            .totalTransaction()[1]
                            .toString()),
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: colorId.lightRed,
                            radius: 6.00,
                          ),
                        ),
                        title: const Text('Expence'),
                        trailing: Text(TransactionDB.instance
                            .totalTransaction()[2]
                            .toString()),
                      ),
                      const SizedBox(height: 30.0),
                      Divider(color: colorId.black),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: colorId.purple,
                          radius: 6.00,
                        ),
                        title: const Text('Balance'),
                        trailing: Text(TransactionDB.instance
                            .totalTransaction()[0]
                            .toString()),
                      ),
                      Divider(color: colorId.black),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

  final filterArray = FilterArray();

  final colorId = ColorsID();
}
