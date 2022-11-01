// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/FunctionsCategory/category_db_f.dart';
import 'package:budgetory_v1/DB/Transactions/transaction_db_f.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/Screens/Category%20Screen/Widgets/radio_functions.dart';
import 'package:flutter/material.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

Future<void> popUpCaBtnCategoryRadio(BuildContext context) async {
  CategoryDB.instance.refreshUI();
  TransactionDB.instance.refreshUiTransaction();
  CategoryDB.instance.refreshUI();
  final categoryController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Center(child: Text('Category')),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              RadioFunction(
                tittle: 'Income',
                type: CategoryType.income,
              ),
              RadioFunction(
                tittle: 'Expense',
                type: CategoryType.expense,
              ),
            ],
          ),
          //*add new category
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: categoryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //******* */
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                final cat = categoryController.text;
                if (cat.isEmpty) {
                  return;
                } else {
                  late final type = selectedCategory.value;
                  late final category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: cat,
                      type: type);

                  CategoryDB().insertCategory(category);
                  CategoryDB().getCategories();
                  print(CategoryDB().getCategories().toString());
                  Navigator.of(ctx).pop();
                  print('🎉🎉Category  box closed');
                }
              },
              child: const Text('Add Category'),
            ),
          )
        ],
      );
    },
  );
}
