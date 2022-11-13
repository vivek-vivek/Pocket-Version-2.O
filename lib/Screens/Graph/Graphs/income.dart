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
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                children: [
                  // ~Today expence

                  ElevatedButton(
                    clipBehavior: Clip.none,
                    onPressed: () {
                      setState(() {
                        modalDummy =
                            TransactionDB.instance.todayIncomeNotifier.value;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorId.btnColor),
                    child: Text(
                      "Today ",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: colorId.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.00),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // ~all expence

                  ElevatedButton(
                    clipBehavior: Clip.none,
                    onPressed: () {
                      setState(() {
                        modalDummy =
                            TransactionDB.instance.IncomeNotifier.value;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 55, 114, 146)),
                    child: Text(
                      "All",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: colorId.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.00),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 205.000, bottom: 8),
                child: Text(
                  "Monthly",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: colorId.btnColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20.00),
                  ),
                ),
              ),
              Container(
                height: 170.00,
                decoration: BoxDecoration(
                    color: colorId.black,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: filterArray.monthList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemBuilder: (context, index) {
                    final i = index;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorId.veryLightGrey,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () async {
                            setState(
                              () {
                                try {
                                  final customMonth =
                                      filterArray.newMonthList[i];
                                  Filter.instance.filterTransactionFunction(
                                      customMonth: customMonth);
                                  modalDummy = Filter
                                      .instance.incomeMonthlyNotifier.value;
                                } catch (e) {
                                  print("🚫 in  month choosing \n $e");
                                } finally {
                                  Navigator.of(context).pop();
                                }
                              },
                            );
                          },
                          child: Text(
                            filterArray.monthList[index],
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: colorId.btnColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(color: colorId.veryLightGrey),
              Container(
                height: 600.000,
                decoration: BoxDecoration(color: colorId.veryLightGrey),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40.00,
                width: 200.00,
                child: AppBar(
                  iconTheme: IconThemeData(color: colorId.btnColor),
                  elevation: 0,
                  backgroundColor: colorId.white,
                  title: Text(
                    "Filter",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: colorId.btnColor, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
