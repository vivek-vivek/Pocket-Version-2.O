
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';
import '../../../../DB/Transactions/transaction_db_f.dart';

class ScreenAllT extends StatefulWidget {
  const ScreenAllT({super.key});

  @override
  State<ScreenAllT> createState() => _ScreenAllTState();
}

class _ScreenAllTState extends State<ScreenAllT>
    with SingleTickerProviderStateMixin {
  // ^Tab controller
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  text: 'All',
                ),
                Tab(
                  text: 'Recent',
                ),
                Tab(
                  text: 'Category',
                ),
                Expanded(
                  child: TabBarView(
                    children: [],
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

