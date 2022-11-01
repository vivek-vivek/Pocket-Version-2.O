import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'transaction_modal.g.dart';

@HiveType(typeId: 3)
class TransactionModal {
  @HiveField(0)
  final String notes;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel categoryTransaction;
  @HiveField(5)
  String? id;
  TransactionModal({
    required this.notes,
    required this.amount,
    required this.date,
    required this.type,
    required this.categoryTransaction,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
