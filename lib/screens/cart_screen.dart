import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/home_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int selectedRadio;
  late int selectedRadioTile;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 100),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 8, bottom: 20),
                      alignment: Alignment.topRight,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        label: const Text(
                          "Clear cart",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        icon: const Icon(
                          Icons.cancel,
                          size: 13,
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(218, 83, 77, 1.0)),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 13, top: 13),
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                              color: Colors.grey,
                            )),
                          ),
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Image.network(
                                'https://cdn.tgdd.vn/Products/Images/1942/277436/google-sony-4k-55-inch-xr-55x90k-02.jpg',
                                width: 98,
                                height: 68,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Product 1',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Quality: ",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.add,
                                          size: 14,
                                        )),
                                    const Text("1",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        )),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 14,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Price',
                                  style: TextStyle(
                                    color: Color.fromRGBO(91, 184, 93, 1),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 13, top: 13),
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                              color: Colors.grey,
                            )),
                          ),
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Image.network(
                                'https://cdn.tgdd.vn/Products/Images/1942/277436/google-sony-4k-55-inch-xr-55x90k-02.jpg',
                                width: 98,
                                height: 68,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Product 1',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Quality: ",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.add,
                                          size: 14,
                                        )),
                                    const Text("1",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        )),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 14,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Price',
                                  style: TextStyle(
                                    color: Color.fromRGBO(91, 184, 93, 1),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 13, top: 13),
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                              color: Colors.grey,
                            )),
                          ),
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Image.network(
                                'https://cdn.tgdd.vn/Products/Images/1942/277436/google-sony-4k-55-inch-xr-55x90k-02.jpg',
                                width: 98,
                                height: 68,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Product 1',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Quality: ",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.add,
                                          size: 14,
                                        )),
                                    const Text("1",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        )),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 14,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Price',
                                  style: TextStyle(
                                    color: Color.fromRGBO(91, 184, 93, 1),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100,
                          ),
                          Row(
                            children: [
                              Text(
                                "Temporary price: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              Text(
                                "200 USD",
                                style: TextStyle(
                                    color: Color.fromRGBO(91, 184, 93, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: const Text("ADDRESS"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Radio(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.green),
                                value: 1,
                                groupValue: selectedRadioTile,
                                onChanged: (val) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile(val!);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Name",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "|",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "Phone number",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "address",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "address",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Radio(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.green),
                                value: 2,
                                groupValue: selectedRadioTile,
                                onChanged: (val) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile(val!);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Name",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "|",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "Phone number",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "address",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "address",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                        TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.center,
                            ),
                            child: const Text(
                              "Add another address",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 13),
                            ))
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            alignment: Alignment.bottomLeft,
                            child: const Text("DISCOUNT"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 240,
                                  height: 40,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.discount_outlined,
                                        size: 20,
                                      ),
                                      hintText: 'Enter the discount code',
                                    ),
                                  )),
                              SizedBox(
                                width: 95,
                                height: 32,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(91, 184, 93, 1),
                                  ),
                                  child: const Text("Apply"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, 1),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      },
                      label: const Text("Continue Shopping"),
                      icon: const Icon(Icons.arrow_circle_left_rounded),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(91, 184, 93, 1),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text("Check out"),
                      icon: const Icon(Icons.shopping_cart),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(239, 172, 78, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
