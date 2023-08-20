import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/cart_screen.dart';
import 'package:mobile_store_app/screens/detail_screen.dart';
import 'package:mobile_store_app/screens/home_screen.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List pages = [
    HomeScreen(),
    CartScreen(),
    DetailScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[0],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}