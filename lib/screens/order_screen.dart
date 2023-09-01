import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
        color: Colors.white,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Text("Hello $index");
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: 20));
  }
}
