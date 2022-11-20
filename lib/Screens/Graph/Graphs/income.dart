// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../DB/transaction_db_f.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../../colors/color.dart';
import '../../../controller/filter_array.dart';
import '../../../controller/filter_controller.dart';

class Income extends StatefulWidget {
  const Income({super.key});
  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  String? timeDropValue;
  List<TransactionModal> modalDummy = [];
  var timeDropList = [
    'Today',
    'Monthly',
  ];

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
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              height: 30.000,
              decoration: BoxDecoration(
                  color: colorId.btnColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 4),
                child: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: colorId.white,
                  ),
                  dropdownColor: colorId.btnColor,
                  borderRadius: BorderRadius.circular(20),
                  elevation: 0,
                  isDense: true,
                  underline: const SizedBox(),
                  value: timeDropValue,
                  items: timeDropList.map(
                    (String timeDropList) {
                      return DropdownMenuItem(
                        value: timeDropList,
                        child: SizedBox(
                          height: 40.00,
                          width: 60.00,
                          child: Text(
                            timeDropList,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: colorId.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    timeDropValue = value!;
                    if (timeDropValue == filterArray.timeDropList[0]) {
                      setState(() {
                        modalDummy = Filter.instance.incomeTodayNotifier.value;
                      });
                    }
                    // ^month picker

                    else if (timeDropValue == filterArray.timeDropList[1]) {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return SimpleDialog(
                            children: [
                              Container(
                                width: 300.00,
                                height: 234.00,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: GridView.builder(
                                  itemCount: filterArray.monthList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4),
                                  itemBuilder: (context, index) {
                                    final i = index;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: colorId.btnColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: TextButton(
                                          onPressed: () async {
                                            setState(
                                              () {
                                                final customMonth =
                                                    filterArray.newMonthList[i];

                                                Filter.instance
                                                    .filterTransactionFunction(
                                                        customMonth:
                                                            customMonth);

                                                modalDummy = Filter
                                                    .instance
                                                    .incomeMonthlyNotifier
                                                    .value;
                                              },
                                            );
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text(
                                            filterArray.monthList[index],
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: colorId.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(
              top: 100.00,
            ),
            child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.IncomeNotifier,
              builder: (BuildContext context, List<TransactionModal> newList,
                  Widget? _) {
                return modalDummy.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                                image: AssetImage('Assets/empty3.jpeg')),
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
