import 'package:budgetory_v1/DB/transaction_db_f.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../colors/color.dart';
import '../../../controller/filter_array.dart';
import '../../../controller/filter_controller.dart';

class AllGraph extends StatefulWidget {
  const AllGraph({super.key});

  @override
  State<AllGraph> createState() => _AllGraphState();
}

class _AllGraphState extends State<AllGraph> {
  @override
  Widget build(BuildContext context) {
    final List<TransactionModal> chartData;
    chartData = TransactionDB.instance.transactionListNotifier.value;
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
            padding: const EdgeInsets.only(top: 100.00),
            child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext context, List<TransactionModal> newList,
                  Widget? _) {
                return modalDummy.isEmpty
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
                          DoughnutSeries<TransactionModal, String>(
                            dataSource: chartData,
                            xValueMapper: (TransactionModal data, _) =>
                                data.categoryTransaction.type.name,
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
          ),
        ],
      ),
    );
  }

  final colorId = ColorsID();
  final filterArray = FilterArray();
  List<TransactionModal> modalDummy = [];
}
