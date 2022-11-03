import 'package:budgetory_v1/DB/FunctionsCategory/category_db_f.dart';
import 'package:budgetory_v1/Screens/Add%20New2/Home/add_new.dart';
import 'package:budgetory_v1/Screens/All%20Transaction%20screen/Home%20screen/widgets/expence.dart';
import 'package:budgetory_v1/Screens/All%20Transaction%20screen/Home%20screen/widgets/income.dart';
import 'package:budgetory_v1/Screens/All%20Transaction%20screen/Home%20screen/widgets/recent.dart';
import 'package:flutter/material.dart';

import '../../../../DB/Transactions/transaction_db_f.dart';
import '../../../../colors/color.dart';

class AllTransaction extends StatefulWidget {
  const AllTransaction({super.key});

  @override
  State<AllTransaction> createState() => _AllTransactionState();
}

class _AllTransactionState extends State<AllTransaction>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Expense.instance.refreshUiTransaction();
  
    CategoryDB.instance.refreshUI();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorId.lightBlue,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Transactions',
          style: TextStyle(color: colorId.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(),
            ),
            TabBar(
              labelColor: colorId.black,
              controller: tabController,
              tabs: const [
                Tab(text: 'Recent'),
                Tab(text: 'Income'),
                Tab(text: 'Expences'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  RecentTransaction(),
                  IncomeAllTransaction(),
                  ExpencesAllTransaction()
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    child: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddTransaction(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  final colorId = ColorsID();
}
