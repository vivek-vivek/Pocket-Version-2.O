import 'package:budgetory_v1/colors/color.dart';
import 'package:budgetory_v1/controller/filter_array.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'filter_controller.dart';

class Nameless {
  final filterArray = FilterArray();
  final colorId = ColorsID();
  ffa(
      {required categoryDropValue,
      required timeDropValue,
      required context,
      required modalDummy}) {
    if (timeDropValue == filterArray.timeDropList[0]) {
      return modalDummy = Filter.instance.allTodayNotifier.value;
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
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: GridView.builder(
                  itemCount: filterArray.monthList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    final i = index;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorId.btnColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () async {
                            try {
                              final customMonth = filterArray.newMonthList[i];

                              Filter.instance.filterTransactionFunction(
                                  customMonth: customMonth);

                              print({customMonth, i});
                              print(customMonth);
                              print(modalDummy);
                              modalDummy =
                                  Filter.instance.allMonthlyNotifier.value;
                            } catch (e) {
                              print("🚫 in  month choosing \n $e");
                            } finally {
                              Navigator.of(context).pop();
                            }
                            ;
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
    } else if (timeDropValue == filterArray.timeDropList[2]) {
      try {
        Filter.instance.customDateAll(context: context);
        modalDummy = Filter.instance.dateRangeList.value;
      } catch (e) {
        print(e);
      }
    }
  }
}
