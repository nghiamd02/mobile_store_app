import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/screen_login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ScreenLogin(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_back_ios_new_sharp), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: ""),
          ],
          currentIndex: _currentIndexPage,
          onTap: (value) {
            setState(() {
              _currentIndexPage = value;
            });
          },
        ),
      ),
    );
  }
}
