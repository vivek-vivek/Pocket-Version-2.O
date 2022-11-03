import 'package:budgetory_v1/DB/FunctionsCategory/category_db_f.dart';
import 'package:budgetory_v1/DB/Transactions/transaction_db_f.dart';
import 'package:budgetory_v1/Screens/Graph/screen_four.dart';
import 'package:budgetory_v1/Screens/Home/home.dart';
import 'package:budgetory_v1/Screens/Category%20Screen/Screen/category_home.dart';
import 'package:budgetory_v1/Screens/Add%20New2/Home/add_new.dart';
import 'package:budgetory_v1/Screens/Settings/user.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final _controller = PageController();

  @override
  void initState() {
    Expense.instance.refreshUiTransaction();
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    Expense.instance.refreshUiTransaction();
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          const HomeScreen(),
          const AddTransaction(),
          const AllCategories(),
          GraphScreen(),
          const UserPage()
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        itemColor: Colors.grey,
        color: colorId.white,
        activeItemColor: colorId.lightBlue,
        controller: _controller,
        flat: true,
        useActiveColorByDefault: true,
        items: const [
          RollingBottomBarItem(Icons.home, label: 'HOME'),
          RollingBottomBarItem(Icons.add_circle_outline_sharp),
          RollingBottomBarItem(Icons.view_compact_alt_outlined),
          RollingBottomBarItem(Icons.graphic_eq),
          RollingBottomBarItem(Icons.account_circle),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }

  final colorId = ColorsID();
}
