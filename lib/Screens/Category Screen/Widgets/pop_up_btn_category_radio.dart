// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/FunctionsCategory/category_db_f.dart';
import 'package:budgetory_v1/DB/Transactions/transaction_db_f.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/Screens/Category%20Screen/Widgets/radio_functions.dart';
import 'package:flutter/material.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

Future<void> popUpCaBtnCategoryRadio(
    {required BuildContext context, required selectedTypeCat}) async {
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
            children: [
              RadioFunction(
                tittle: 'Income',
                type: CategoryType.income,
                selectedType: selectedTypeCat,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 15),
                child: RadioFunction(
                  tittle: 'Expense',
                  type: CategoryType.expense,
                  selectedType: null,
                ),
              ),
            ],
          ),
          //*add new category
          Padding(
             padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: 10,
              controller: categoryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'enter category';
                }
                return null;
              },
            ),
          ),
          //******* */
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
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
                  await CategoryDB.instance.refreshUI();
                  // ignore: use_build_context_synchronously
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
