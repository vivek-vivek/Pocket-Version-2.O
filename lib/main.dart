import 'package:budgetory_v1/DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/Screens/Splash%20Screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'DB/FunctionsCategory/category_db_f.dart';
import 'DB/Transactions/transaction_db_f.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //* TransactionDbAmount registering or opening
  if (!Hive.isAdapterRegistered(TransactionDbAmountAdapter().typeId)) {
    Hive.registerAdapter(TransactionDbAmountAdapter());
  }
  //* category Db registering or opening
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  //*categoryType adapter register checking / start
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  //*Transaction Modal adapter register checking / start
  if (!Hive.isAdapterRegistered(TransactionModalAdapter().typeId)) {
    Hive.registerAdapter(TransactionModalAdapter());
  }
  CategoryDB.instance.refreshUI();
  TransactionDB.instance.refreshUiTransaction();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(),
      home: SplashScreen(),
    );
  }
}
