import 'package:budgetory_v1/Screens/Bottom%20Navigation/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
  //  CategoryDB.instance.refreshUI();
  //   TransactionDB.instance.refreshUiTransaction();
    return SplashScreenView(
      navigateRoute: const BottomNavigationScreen(),
      duration: 5000,
      imageSize: 130,
      imageSrc: 'Assets/logo.png',
      backgroundColor: Colors.white,
    );
  }
}
