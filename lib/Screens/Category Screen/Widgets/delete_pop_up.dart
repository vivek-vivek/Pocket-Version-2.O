// ignore_for_file: use_build_context_synchronously

import 'package:budgetory_v1/Screens/Category%20Screen/Widgets/success.dart';
import 'package:flutter/material.dart';

import '../../../DB/FunctionsCategory/category_db_f.dart';

popDeleteFunction({required BuildContext context, required String id}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text(
            "Do You want delete permanently?",
            style: TextStyle(color: Colors.orange),
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
                      child: const Text(
                        'delete',
                        style: TextStyle(color: Colors.red),
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
      });
}
