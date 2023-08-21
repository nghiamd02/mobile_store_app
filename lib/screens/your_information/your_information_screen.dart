import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/search/search_bar.dart';
import 'package:mobile_store_app/screens/your_information/address_list.dart';
import 'package:mobile_store_app/screens/your_information/nav_bar_user_infor.dart';
import 'package:mobile_store_app/screens/your_information/user_information.dart';

class YourInformationScreen extends StatelessWidget {
  const YourInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          NavBarUserInfor(),
          UserInformation(),
          Expanded(child: AddressList())
        ],
      ),
    );
  }
}
