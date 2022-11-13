// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../DB/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';
import '../../../controller/filter_array.dart';

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
          Padding(
            padding: const EdgeInsets.only(top: 100.00,),
            child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.IncomeNotifier,
              builder: (BuildContext context, List<TransactionModal> newList,
                  Widget? _) {
                return newList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(image: AssetImage('Assets//empty3.jpeg')),
                            Text(
                              "No Transactions Found",
                              style: TextStyle(color: colorId.veryLightGrey),
                            )
                          ],
                        ),
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
            ),
          )
        ],
      ),
    );
  }

// ^-------------------------------------------------------------------------------------------------------

  final filterArray = FilterArray();
  final colorId = ColorsID();
}
