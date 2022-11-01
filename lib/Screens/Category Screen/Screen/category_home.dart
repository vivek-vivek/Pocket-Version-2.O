// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/FunctionsCategory/category_db_f.dart';
import 'package:budgetory_v1/Screens/Category%20Screen/Screen/pop.dart';
import 'package:budgetory_v1/Screens/Category%20Screen/Widgets/pop_up_btn_category_radio.dart';
import 'package:budgetory_v1/Screens/Category%20Screen/Widgets/expences.dart';
import 'package:budgetory_v1/Screens/Category%20Screen/Widgets/income.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    //*getting  category's from db
    //  CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    // TransactionDB.instance.refreshUiTransaction();
    // CategoryDB().refreshUI();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              indicatorColor: colorId.lightBlue,
              labelColor: colorId.black,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Income',
                ),
                Tab(text: 'Expense'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  IncomeTabPage(),
                  ExpensesTabPage(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 440.000,
                decoration: BoxDecoration(
                    color: colorId.lightBlue,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: TextButton(
                  onPressed: () {
                    print(_tabController.index);
                    pop(
                      context: context,
                      tabBarIndex: _tabController.index,
                    );
                  },
                  child: const Text('Add Category'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final colorId = ColorsID();
}
