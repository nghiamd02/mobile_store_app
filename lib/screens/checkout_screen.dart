import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckoutPage(),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedPaymentOption = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: const Color.fromARGB(255, 252, 255, 255),
          child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Image.asset('assets/img/placeholder 1.png'),
                            const Text(
                              "Delivery address",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Row(
                            children: [
                              Text(
                                "Tran Ky Anh",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff000000),
                                ),
                              ),
                              Text(
                                "| 0583841958",
                                style: TextStyle(
                                  wordSpacing: 3,
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff979595),
                                ),
                              ),
                            ],
                          )),
                      Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "273 Ly Thuong Kiet",
                                style: TextStyle(
                                  wordSpacing: 3,
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff979595),
                                ),
                              ),
                              Text(
                                "6 ward, district 8, HoChiMinh city",
                                style: TextStyle(
                                  wordSpacing: 3,
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff979595),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Image.asset('assets/img/payment-protection 1.png'),
                            const SizedBox(
                              width: 3,
                            ),
                            const Text(
                              "Payment detailes",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        color: const Color.fromARGB(255, 255, 1, 9),
                        padding: const EdgeInsets.symmetric(
                          vertical:
                          100, // Điều chỉnh giá trị vertical để thay đổi khoảng cách trên và dưới
                          horizontal:
                          100, // Điều chỉnh giá trị horizontal để thay đổi khoảng cách trái và phải
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Select form to pay:",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RadioListTile<int>(
                                title: Row(
                                  children: [
                                    Image.asset('assets/img/image 15.png'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text("Wallet Momo"),
                                  ],
                                ),
                                value: 0,
                                groupValue: selectedPaymentOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentOption = value!;
                                  });
                                },
                                activeColor: Color(0xFF5BB85D)),
                            RadioListTile<int>(
                                title: Row(
                                  children: [
                                    Image.asset('assets/img/money 1.png'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text("Pay after receive order"),
                                  ],
                                ),
                                value: 1,
                                groupValue: selectedPaymentOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentOption = value!;
                                  });
                                },
                                activeColor: Color(0xFF5BB85D)),
                            RadioListTile<int>(
                              title: Row(
                                children: [
                                  Image.asset('assets/img/debit-card 1.png'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("Banking"),
                                ],
                              ),
                              value: 2,
                              groupValue: selectedPaymentOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedPaymentOption = value!;
                                });
                              },
                              activeColor: Color(0xFF5BB85D),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Xử lý khi nhấn nút Pay
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF5BB85D), // Màu nền xanh
                      minimumSize:
                      const Size(400, 50), // Đặt chiều rộng là full width
                    ),
                    child: const Text(
                      "Pay",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}