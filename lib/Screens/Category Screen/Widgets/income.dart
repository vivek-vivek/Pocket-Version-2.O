// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/FunctionsCategory/category_db_f.dart';
import 'package:budgetory_v1/Screens/Category%20Screen/Widgets/delete_pop_up.dart';
import 'package:flutter/material.dart';
import '../../../DataBase/Models/ModalCategory/category_model.dart';
import '../../../colors/color.dart';

class IncomeTabPage extends StatefulWidget {
  const IncomeTabPage({super.key});

  @override
  State<IncomeTabPage> createState() => _IncomeTabPageState();
}

class _IncomeTabPageState extends State<IncomeTabPage> {
   @override
  void initState() {
    bool indexRadio = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      bool indexRadio = true;
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryModelList,
      builder: (BuildContext context, List<CategoryModel> newCategoryModelList,
          Widget? _) {
        return GridView.builder(
          itemCount: newCategoryModelList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 40.00,
              crossAxisSpacing: 0.00,
              crossAxisCount: 3),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          category.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        popDeleteFunction(context: context, id: category.id);
                        print('🎉🎉🚫DELETED');
                      },
                      icon: const Icon(Icons.delete_rounded),
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
