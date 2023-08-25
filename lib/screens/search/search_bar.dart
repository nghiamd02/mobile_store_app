import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/screen_login.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            width: double.maxFinite,
            height: 162,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
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
                    icon: const Icon(Icons.menu),
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
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tran Ky Anh - 0123456789',
                        style: TextStyle(
                            backgroundColor: Color.fromARGB(76, 158, 158, 158)),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ScreenLogin(),
                            ));
                          },
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
        ],
      ),
    );
  }
}
