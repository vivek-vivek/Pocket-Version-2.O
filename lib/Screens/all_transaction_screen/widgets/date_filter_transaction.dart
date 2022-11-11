
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../DataBase/Models/ModalCategory/category_model.dart';
import '../../../colors/color.dart';

dateFilterTransaction({required timeValue, required newValue}) {
  // colorID is class that contain all colors
  final colorId = ColorsID();
  if (timeValue == 'Today') {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: newValue.type == CategoryType.expense
              ? colorId.lightRed
              : colorId.lightGreen,
        ),
      ),
      title: Text(newValue.notes),
      subtitle: Text(DateFormat.yMMMMd().format(newValue.date)),
      trailing: Text(
        newValue.amount.toString(),
      ),
    );
  }
 
}
