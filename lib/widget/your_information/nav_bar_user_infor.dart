import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/promotion_screen.dart';
import 'package:mobile_store_app/screens/your_information/your_information_screen.dart';

class NavBarUserInfor extends StatelessWidget {
  const NavBarUserInfor({super.key, required this.onNavBarClicked});

  final void Function(int index) onNavBarClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 90,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              onNavBarClicked(0);
            },
            child: Column(
              children: [
                SizedBox(
                  width: 40, // Đặt kích thước cố định cho hình ảnh
                  height: 40, // Đặt kích thước cố định cho hình ảnh
                  child: Image.asset('assets/img/image 29.png'),
                ),
                const Text("Your infomation",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                      height: 31 / 14,
                    ))
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, '/order'); // Điều hướng đến route "Order"
            },
            child: Column(
              children: [
                SizedBox(
                  width: 40, // Đặt kích thước cố định cho hình ảnh
                  height: 40, // Đặt kích thước cố định cho hình ảnh
                  child: Image.asset('assets/img/shopping-bag 1.png'),
                ),
                const Text("Order",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                      height: 31 / 14,
                    ))
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              onNavBarClicked(1);
            },
            child: Column(
              children: [
                SizedBox(
                  width: 40, // Đặt kích thước cố định cho hình ảnh
                  height: 40, // Đặt kích thước cố định cho hình ảnh
                  child: Image.asset('assets/img/promotion 1.png'),
                ),
                const Text("Promotion",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                      height: 31 / 14,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
