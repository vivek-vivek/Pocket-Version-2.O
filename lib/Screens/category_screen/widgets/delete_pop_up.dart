// ignore_for_file: use_build_context_synchronously

import 'package:budgetory_v1/Screens/category_screen/widgets/success.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';

import '../../../DB/category_db_f.dart';

popDeleteFunction({required BuildContext context, required String id}) {
  final colorId = ColorsID();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title:  Text(
          "Do You want delete permanently?",
          style: TextStyle(color: colorId.btnColor),
        ),
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: () async {
                      await CategoryDB.instance.deleteDB(id);
                      Navigator.of(context).pop(ctx);
                      await success(context);
                    },
                    child: Text(
                      'delete',
                      style: TextStyle(color: Colors.red[400]),
                    )),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(ctx);
                  },
                  child: const Text(
                    'cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
