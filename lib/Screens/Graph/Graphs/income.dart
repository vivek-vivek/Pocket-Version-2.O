// ignore_for_file: avoid_print

import 'package:budgetory_v1/Screens/All%20Transaction%20screen/widgets/category_filter.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../DB/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';
import '../../All Transaction screen/widgets/filter_array.dart';

class Income extends StatefulWidget {
  const Income({super.key});
  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  String? timeDropValue;
  List<TransactionModal> modalDummy = [];

  @override
  void initState() {
    TransactionDB.instance.refreshUiTransaction();
    modalDummy = TransactionDB.instance.IncomeNotifier.value;
    timeDropValue = 'Today';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUiTransaction();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.00),
            child: DropdownButton(
              dropdownColor: colorId.lightBlue,
              elevation: 0,
              isDense: true,
              underline: const SizedBox(),
              value: timeDropValue,
              items: filterArray.timeDropList.map(
                (String timeDropList) {
                  return DropdownMenuItem(
                    value: timeDropList,
                    child: SizedBox(
                      height: 30.00,
                      width: 60.00,
                      child: Text(timeDropList),
                    ),
                  );
                },
              ).toList(),
              onTap: () {
                if (timeDropValue == filterArray.timeDropList[0]) {
                  modalDummy = TransactionDB.instance.todayIncomeNotifier.value;
                } else if (timeDropValue == filterArray.timeDropList[1]) {
                  modalDummy = TransactionDB.instance.weeklyNotifier.value;
                } else if (timeDropValue == filterArray.timeDropList[2]) {
                  modalDummy = TransactionDB.instance.MonthlyNotifier.value;
                }
              },
              onChanged: (value) {
                setState(
                  () {
                    timeDropValue = value;
                  },
                );
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: TransactionDB.instance.IncomeNotifier,
            builder: (BuildContext context, List<TransactionModal> newList,
                Widget? _) {
              return newList.isEmpty
                  ? const Center(
                      child: Text('welcome!!!👋👋Add some new Transactions'),
                    )
                  : SfCircularChart(
                      backgroundColor: colorId.white,
                      legend: Legend(isVisible: true),
                      series: <CircularSeries>[
                        // Render pie chart
                        DoughnutSeries<TransactionModal, String>(
                          dataSource: modalDummy,
                          xValueMapper: (TransactionModal data, _) =>
                              data.notes,
                          yValueMapper: (TransactionModal data, _) =>
                              data.amount.round(),
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                        )
                      ],
                    );
            },
          )
        ],
      ),
    );
  }

// ^-------------------------------------------------------------------------------------------------------

  final filterCategory = Filtered();
  final filterArray = FilterArray();
  final colorId = ColorsID();
}
