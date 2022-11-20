// ignore_for_file: avoid_print

import 'package:budgetory_v1/DB/category_db_f.dart';
import 'package:budgetory_v1/screens/category_screen/widgets/delete_pop_up.dart';
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
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryModelList,
      builder: (BuildContext context, List<CategoryModel> newCategoryModelList,
          Widget? _) {
        return GridView.builder(
          itemCount: newCategoryModelList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 40.00,
              crossAxisSpacing: 0.00,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            final category = newCategoryModelList[index];
            return Padding(
              padding:
                  const EdgeInsets.only(top: 20.00, left: 20.00, right: 20.00),
              child: Container(
                decoration: BoxDecoration(
                  color: colorId.btnColor,
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
                          icon:  Icon(Icons.delete_rounded,color: colorId.white,),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.00),
                        child: Text(
                          category.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorId.white),
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
