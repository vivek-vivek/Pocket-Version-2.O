import 'package:budgetory_v1/Screens/Graph/Graph%20Detalies/all_details.dart';
import 'package:budgetory_v1/Screens/Graph/Graphs/All.dart';
import 'package:budgetory_v1/Screens/Graph/Graphs/expence.dart';
import 'package:budgetory_v1/Screens/Graph/Graphs/income.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen>
    with SingleTickerProviderStateMixin {
  late TabController newTabController;
  @override
  void initState() {
    super.initState();
    newTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
//^-------------------------------------Graphs------------------------------------
              SizedBox(
                width: double.infinity,
                height: 300.00,
                child: TabBarView(
                  controller: newTabController,
                  children: [
                    const AllGraph(),
                    Income(),
                    Expences(),
                  ],
                ),
              ),
//^-------------------------------------End---------------------------------------
//
//^----------------------------------Tab Items------------------------------------

              Container(
                width: double.infinity,
                color: colorId.purple,
                child: Column(
                  children: [
                    TabBar(
                      indicator: ShapeDecoration(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          color: colorId.veryLightGrey),
                      indicatorWeight: 1.00,
                      indicatorColor: colorId.purple,
                      labelColor: colorId.black,
                      unselectedLabelColor: colorId.grey,
                      controller: newTabController,
                      tabs: const [
                        Tab(text: 'All'),
                        Tab(text: 'Income'),
                        Tab(text: 'Expense'),
                      ],
                    ),
                  ],
                ),
              ),

//^----------------------------------end------------------------------------

// ^--------------------------------details tab-----------------------------

              Expanded(
                child: TabBarView(
                  controller: newTabController,
                  children: [
                   const AllGraphDetails(),
                    Income(),
                    Expences(),
                  ],
                ),
              )

//^----------------------------------end------------------------------------
            ],
          ),
        ),
      ),
    );
  }

  final colorId = ColorsID();
}
