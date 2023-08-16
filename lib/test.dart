import 'package:flutter/material.dart';

class MyTestClass extends StatefulWidget {
  const MyTestClass({super.key});

  @override
  State<MyTestClass> createState() => _MyTestClassState();
}

class _MyTestClassState extends State<MyTestClass> {
  late TextEditingController _searchController;
  List<String> myList = List.generate(20, (index) => "Iphone ${index + 1}");
  late List<String> _filterdList;
  @override
  void initState() {
    super.initState();
    myList = List.generate(20, (index) => "Iphone ${index + 1}");
    _searchController = TextEditingController();
    _filterdList = myList;
  }

  Widget notFoundText() {
    return Expanded(
      child: Center(
        child: Text(
          "Not Found!",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            width: double.maxFinite,
            height: 162,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.grey[300],
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54, // shadow color
                      blurRadius: 20, // shadow radius
                      offset: Offset(5, 5.5), // shadow offset
                      spreadRadius:
                          3, // The amount the box should be inflated prior to applying the blur
                      blurStyle: BlurStyle.normal // set blur style
                      ),
                ]),
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      print("Icon Menu Pressed");
                    },
                  ),
                  title: SearchBar(
                    controller: _searchController,
                    trailing: [
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (_searchController.text.isEmpty) {
                            setState(() {
                              _filterdList = myList;
                            });
                            return;
                          }
                          setState(() {
                            _filterdList = myList
                                .where((element) => element
                                    .toLowerCase()
                                    .contains(
                                        _searchController.text.toLowerCase()))
                                .toList();
                          });
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tran Ky Anh - 0123456789',
                        style: TextStyle(
                            backgroundColor: Color.fromARGB(76, 158, 158, 158)),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Log out",
                            style: TextStyle(
                                color: Colors.black87,
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          (_filterdList.isEmpty)
              ? notFoundText()
              : Expanded(
                  child: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: _filterdList.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Text("${index + 1}"),
                    title: Text(_filterdList[index]),
                  ),
                ))
        ],
      )),
    );
  }
}
