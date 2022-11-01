
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';
import '../../../../DB/Transactions/transaction_db_f.dart';

class ScreenAllT extends StatefulWidget {
  const ScreenAllT({super.key});

  @override
  State<ScreenAllT> createState() => _ScreenAllTState();
}

class _ScreenAllTState extends State<ScreenAllT>
    with SingleTickerProviderStateMixin {
  // ^Tab controller
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  text: 'All',
                ),
                Tab(
                  text: 'Recent',
                ),
                Tab(
                  text: 'Category',
                ),
                Expanded(
                  child: TabBarView(
                    children: [],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  final colorId = ColorsID();
}

//  ValueListenableBuilder(
//         valueListenable: TransactionDB.instance.transactionListNotifier,
//         builder:
//             (BuildContext context, List<TransactionModal> newList, Widget? _) {
//           return ListView.builder(
//             itemBuilder: (context, index) {
//               final newValue = newList[index];
//               return Slidable(
//                 key: Key(newValue.id!),
//                 endActionPane: ActionPane(
//                   motion: const DrawerMotion(),
//                   children: [
//                     SlidableAction(
//                       onPressed: (context) {
//                         try {
//                           TransactionDB.instance
//                               .deleteTransaction(newValue.id!);
//                         } catch (e) {
//                           print(e);
//                         }
//                       },
//                       icon: Icons.delete,
//                       foregroundColor: colorId.red,
//                       backgroundColor: colorId.veryLightGrey,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(80.000),
//                         ),
//                         color: colorId.white,
//                       ),
//                       child: ListTile(
//                         leading: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CircleAvatar(
//                             backgroundColor:
//                                 newValue.type == CategoryType.income
//                                     ? colorId.lightGreen
//                                     : colorId.lightRed,
//                           ),
//                         ),
//                         subtitle: Text(
//                           DateFormat.MMMMEEEEd().format(newValue.date),
//                         ),
//                         title: Text(newValue.notes),
//                         trailing: Text(
//                           newValue.amount.toString(),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10.000)
//                   ],
//                 ),
//               );
//             },
//             itemCount: newList.length,
//           );
//         },
//       ),
