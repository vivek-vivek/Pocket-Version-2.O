// //*radio button for add category
// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_print

import 'package:budgetory_v1/screens/category_screen/widgets/pop_up_btn_category_radio.dart';
import 'package:flutter/material.dart';

import '../../../DataBase/Models/ModalCategory/category_model.dart';

class RadioFunction extends StatelessWidget {
  final CategoryType type;
  final String tittle;
  const RadioFunction({super.key, required this.type, required this.tittle,required selectedType});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedCategory,
      builder: (BuildContext context, CategoryType newCategoryType, Widget? _) {
        return Row(
          children: [
            Radio(
                value: type,
                groupValue: newCategoryType,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategory.value = value;
                  selectedCategory.notifyListeners();
                  print(selectedCategory.value.toString());
                  print('🎉Radio');
                }),
            Text(tittle)
          ],
        );
      },
    );
  }
}
