import 'package:budgetory_v1/DB/Transactions/transaction_db_f.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../../../colors/color.dart';

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
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder:
          (BuildContext context, List<TransactionModal> newList, Widget? _) {
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
                    dataSource: chartData,
                    xValueMapper: (TransactionModal data, _) =>
                        data.categoryTransaction.type.name,
                    yValueMapper: (TransactionModal data, _) =>
                        data.amount.round(),
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                  )
                ],
              );
      },
    );
  }

  final colorId = ColorsID();
}
