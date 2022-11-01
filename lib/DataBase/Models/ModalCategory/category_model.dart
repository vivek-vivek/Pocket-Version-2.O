// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name; 

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final CategoryType type;

  var date;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.type,
      this.isDeleted = false});
}

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,

  @HiveField(1)
  expense;
}
