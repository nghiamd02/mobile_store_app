import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/order_screen.dart';
import 'package:mobile_store_app/screens/promotion_screen.dart';
import 'package:mobile_store_app/screens/search_bar.dart';
import 'package:mobile_store_app/widget/bottom_navigation.dart';
import 'package:mobile_store_app/widget/your_information/address_list.dart';
import 'package:mobile_store_app/widget/your_information/nav_bar_user_infor.dart';
import 'package:mobile_store_app/widget/your_information/user_information.dart';

class YourInformationScreen extends StatefulWidget {
  const YourInformationScreen({super.key});

  @override
  State<YourInformationScreen> createState() => _YourInformationScreenState();
}

class _YourInformationScreenState extends State<YourInformationScreen> {
  int _currentScreen = 0;

  final screens = [
    Expanded(
        child: Column(
      children: [UserInformation(), Expanded(child: AddressList())],
    )),
    Expanded(child: OrderScreen()),
    Expanded(child: PromotionScreen())
  ];

  void onNavBarClicked(int index) {
    setState(() {
      _currentScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 162,
            child: CustomSearchBar(),
          ),
          const SizedBox(
            height: 9,
          ),
          NavBarUserInfor(onNavBarClicked: onNavBarClicked),
          screens[_currentScreen],

          //content
        ],
      ),
    );
  }
}
