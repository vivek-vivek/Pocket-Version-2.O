// import 'package:budgetory_v1/colors/color.dart';
// import 'package:budgetory_v1/controller/filter_array.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'filter_controller.dart';

// class Nameless {
//   final filterArray = FilterArray();
//   final colorId = ColorsID();
//   monthPicker(
//       {required categoryDropValue,
//       required timeDropValue,
//       required context,
//       required modalDummy,
//       required notifierValue})async {
//     print("🍎");
//     Filter.instance.allMonthlyNotifier.value.clear;
//     showDialog(
//       context: context,
//       builder: (ctx) {
//         return SimpleDialog(
//           children: [
//             Container(
//               width: 300.00,
//               height: 234.00,
//               decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//               child: GridView.builder(
//                 itemCount: filterArray.monthList.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4),
//                 itemBuilder: (context, index) {
//                   final i = index;
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: colorId.btnColor,
//                           borderRadius: BorderRadius.circular(20)),
//                       child: TextButton(
//                         onPressed: () async {
//                           final customMonth = filterArray.newMonthList[i];

//                           Filter.instance.filterTransactionFunction(
//                               customMonth: customMonth);

//                           modalDummy = notifierValue;

//                           Navigator.of(ctx).pop();
//                         },
//                         child: Text(
//                           filterArray.monthList[index],
//                           style: GoogleFonts.lato(
//                             textStyle: TextStyle(
//                                 color: colorId.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
