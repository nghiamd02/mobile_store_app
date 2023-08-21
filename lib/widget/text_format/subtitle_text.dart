import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  Subtitle({Key? key,
    this.size = 16,
    required this.text,
    this.color = Colors.green}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}