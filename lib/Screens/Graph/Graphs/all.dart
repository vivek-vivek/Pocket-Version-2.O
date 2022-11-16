import 'package:budgetory_v1/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton(
                  value: dropDownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: timeDropList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownValue = newValue!;
                      if (dropDownValue == timeDropList[0]) {
                        Filter.instance.filterTransactionFunction();
                        setState(() {
                          modalDummyList =
                              Filter.instance.allTodayNotifier.value;
                        });
                      } else if (dropDownValue == timeDropList[1]) {
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
                                                      filterArray
                                                          .newMonthList[i];
                                                  Filter.instance
                                                      .filterTransactionFunction(
                                                          customMonth:
                                                              customMonth);
                                                  modalDummyList = Filter
                                                      .instance
                                                      .allMonthlyNotifier
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                    });
                  },
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext context, List<TransactionModal> newList,
                  Widget? _) {
                return modalDummyList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                                image: AssetImage('Assets/empty1.jpeg')),
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
                          PieSeries<TransactionModal, String>(
                            dataSource: modalDummyList,
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
      ),
    );
  }

  final filterArray = FilterArray();
  final colorId = ColorsID();
  final popTransaction = PopUpTransaction();
}
