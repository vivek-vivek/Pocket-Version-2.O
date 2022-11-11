// ignore_for_file: avoid_print
import 'package:budgetory_v1/DB/category_db_f.dart';
import 'package:budgetory_v1/DB/transaction_db_f.dart';
import 'package:budgetory_v1/Screens/category_screen/main_screen/pop.dart';
import 'package:budgetory_v1/Screens/category_screen/widgets/expences.dart';
import 'package:budgetory_v1/Screens/category_screen/widgets/income.dart';
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
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    // TransactionDB.instance.refreshUiTransaction();
    CategoryDB().refreshUI();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: colorId.mainBlue,
                ),
                child: TabBar(
                  unselectedLabelColor: colorId.grey,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colorId.btnColor),
                  indicatorColor: colorId.white,
                  labelColor: colorId.white,
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Income'),
                    Tab(text: 'Expense'),
                  ],
                ),
              ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 14.00),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorId.btnColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.00))),
                    child: IconButton(
                      onPressed: () async {
                        await TransactionDB.instance.refreshUiTransaction();
                        print(_tabController.index);
                        pop(
                          context: context,
                          tabBarIndex: _tabController.index,
                        );
                      },
                      icon: Icon(Icons.add_circle, color: colorId.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final colorId = ColorsID();
}
