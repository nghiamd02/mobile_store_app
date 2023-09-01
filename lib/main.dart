import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/cart_screen.dart';
import 'package:mobile_store_app/screens/detail_screen.dart';
import 'package:mobile_store_app/screens/home_screen.dart';
import 'package:mobile_store_app/screens/screen_login.dart';
import 'package:mobile_store_app/widget/text_format/detail_text.dart';

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
      ),
    );
  }
}
