import 'package:budgetory_v1/Screens/Graph/Graphs/all.dart';
import 'package:budgetory_v1/Screens/Graph/Graphs/expence.dart';
import 'package:budgetory_v1/Screens/Graph/Graphs/income.dart';
import 'package:flutter/material.dart';

import '../../../colors/color.dart';

class HomeGraph extends StatefulWidget {
  const HomeGraph({super.key});
  @override
  State<HomeGraph> createState() => _HomeGraphState();
}

class _HomeGraphState extends State<HomeGraph>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TabBar(
              indicatorWeight: 1,
              indicatorColor: colorId.purple,
              labelColor: colorId.black,
              controller: tabController,
              tabs: const [
                Tab(text: 'Overall'),
                Tab(text: 'Income'),
                Tab(text: 'Expence')
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  const AllGraph(),
                 const Expences(),
                  Income(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final colorId = ColorsID();
}
