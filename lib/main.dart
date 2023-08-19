import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/search/search_bar.dart';
import 'package:mobile_store_app/screens/your_information/your_information_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: YourInformationScreen(),
    );
  }
}
