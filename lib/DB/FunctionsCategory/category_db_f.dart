// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, invalid_use_of_protected_member

import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class CategoryDbFunctions {
  Future<void> insertCategory(CategoryModel value);
  Future<List<CategoryModel>> getCategories();
  Future<void> deleteDB(String id);
}

// ignore: constant_identifier_names
const CATEGORY_DB_NAME = 'category-database';

class CategoryDB implements CategoryDbFunctions {
  ValueNotifier<List<CategoryModel>> incomeCategoryModelList =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryModelList =
      ValueNotifier([]);

  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }
  //*add  a category in to DB
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategory = await getCategories();
    // allCategory.sort((first, second) => second.date.compareTo(first.date));
    incomeCategoryModelList.value.clear();
    expenseCategoryModelList.value.clear();
    Future.forEach(allCategory, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryModelList.value.add(category);
      } else {
        expenseCategoryModelList.value.add(category);
      }
    });
    // ignore: invalid_use_of_visible_for_testing_member
    incomeCategoryModelList.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member
    expenseCategoryModelList.notifyListeners();
  }

  @override
  Future<void> deleteDB(String id) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(id);
    refreshUI();
  }

  Future<void> deleteDBAll() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.clear();
    // selectedCategory.dispose();
    refreshUI();
  }
}
