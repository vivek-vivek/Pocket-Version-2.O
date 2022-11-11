// ignore_for_file: avoid_print

import 'package:budgetory_v1/Controller/filter_controller.dart';
import 'package:budgetory_v1/Screens/all_transaction_screen/widgets/category_filter.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../DB/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';
import '../../all_transaction_screen/widgets/filter_array.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});
  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  String? categoryDropValue;
  String? timeDropValue;
  List<TransactionModal> modalDummy = [];

  @override
  void initState() {
    modalDummy = TransactionDB.instance.expenceNotifier.value;
    timeDropValue = 'Today';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              
              onChanged: (value) {
                setState(
                  () {
                    timeDropValue = value;
                  },
                );
              },
              onTap: () {
                if (timeDropValue == filterArray.timeDropList[0]) {
                  modalDummy = Filter.instance.expenceTodayNotifier.value;
                } else if (timeDropValue == filterArray.timeDropList[1]) {
                  modalDummy = Filter.instance.expenceWeeklyNotifier.value;
                } else if (timeDropValue == filterArray.timeDropList[2]) {
                  modalDummy = Filter.instance.expenceMonthlyNotifier.value;
                }
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: TransactionDB.instance.expenceNotifier,
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
