// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/category_db_f.dart';
import 'package:budgetory_v1/Screens/category_screen/widgets/delete_pop_up.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';

import '../../../DataBase/Models/ModalCategory/category_model.dart';

class ExpensesTabPage extends StatefulWidget {
  const ExpensesTabPage({super.key});

  @override
  State<ExpensesTabPage> createState() => _ExpensesTabPageState();
}

class _ExpensesTabPageState extends State<ExpensesTabPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expenseCategoryModelList,
      builder: (BuildContext context, List<CategoryModel> newCategoryModelList,
          Widget? _) {
        return GridView.builder(
          itemCount: newCategoryModelList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20.00,
              crossAxisSpacing: 20.00,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            final category = newCategoryModelList[index];
            return Padding(
              padding:
                  const EdgeInsets.only(top: 20.00, left: 20.00, right: 20.00),
              child: Container(
                decoration: BoxDecoration(
                  color: colorId.lightRed,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.00),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            popDeleteFunction(
                                context: context, id: category.id);
                            print('🎉🎉🚫DELETED');
                          },
                          icon: const Icon(Icons.delete_rounded),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          category.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  final colorId = ColorsID();
}
