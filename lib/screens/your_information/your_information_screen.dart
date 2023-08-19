import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/search/search_bar.dart';
import 'package:mobile_store_app/screens/your_information/address_list.dart';
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
            child: CustomeSearchBar(),
          ),
          Container(
            margin: const EdgeInsets.all(9),
            width: double.maxFinite,
            height: 84,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
          ),
          UserInformation(),
          Expanded(child: AddressList())
        ],
      ),
    );
  }
}
