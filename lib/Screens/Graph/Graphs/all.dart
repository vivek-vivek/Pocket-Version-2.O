import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../DB/transaction_db_f.dart';
import '../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../colors/color.dart';
import '../../../controller/filter_array.dart';
import '../../all_transaction_screen/widgets/pop_up_transaction.dart';

class AllGraph extends StatefulWidget {
  const AllGraph({super.key});

  @override
  State<AllGraph> createState() => _AllGraphState();
}

class _AllGraphState extends State<AllGraph> {
  List<TransactionModal> modalDummyList = [];
  String dropDownValue = 'Today';
  final colorList = [
    Colors.greenAccent,
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.blueAccent,
    Colors.purpleAccent,
  ];
  Map<TransactionModal, double> dataMap = {};

  List<TransactionModal> pieData = [];

  var timeDropList = [
    'Today',
    'Monthly',
  ];
  @override
  void initState() {
    modalDummyList = TransactionDB.instance.transactionListNotifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ValueListenableBuilder(
            valueListenable: TransactionDB.instance.transactionListNotifier,
            builder: (BuildContext context, List<TransactionModal> newList,
                Widget? _) {
              return modalDummyList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(image: AssetImage('Assets/empty1.jpeg')),
                          Text(
                            "No Transactions Found",
                            style: TextStyle(color: colorId.grey),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only( top:100),
                      child: SizedBox(
                        height: 400,
                        child: PieChart(
                          PieChartData(
                            centerSpaceRadius: 100,
                            borderData: FlBorderData(
                              show: true,
                            ),
                            sections: [
                              PieChartSectionData(
                                  title: 'Income',
                                  titleStyle: TextStyle(color: colorId.white),
                                  color: colorId.btnColor,
                                  value: TransactionDB.instance
                                      .totalTransaction()[1]),
                              PieChartSectionData(
                                titleStyle: TextStyle(color: colorId.white),
                                color: colorId.mainBlue,
                                value: TransactionDB.instance
                                    .totalTransaction()[2],
                              )
                            ],
                          ),
                          swapAnimationDuration:
                              const Duration(milliseconds: 150), // Optional
                          swapAnimationCurve: Curves.linear, // Optional
                        ),
                      ),
                    );
            },
          )
        ],
      ),
    );
  }

  final filterArray = FilterArray();
  final colorId = ColorsID();
  final popTransaction = PopUpTransaction();
}
