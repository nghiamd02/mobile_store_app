import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/cart_screen.dart';
import 'package:mobile_store_app/screens/detail_screen.dart';
import 'package:mobile_store_app/screens/home_screen.dart';
import 'package:mobile_store_app/screens/your_information/your_information_screen.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation();
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List pages = [
    HomeScreen(),
    CartScreen(),
    YourInformationScreen(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.house)),
          BottomNavigationBarItem(
              label: "Cart", icon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(label: "Account", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
