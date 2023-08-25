import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScreenRegister extends StatefulWidget {
  ScreenRegister({Key? key}) : super(key: key);

  @override
  _ScreenRegisterState createState() {
    return _ScreenRegisterState();
  }
}

class _ScreenRegisterState extends State<ScreenRegister> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatpasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
              child: Column(children: [
                // dùng Pading không thể thay đổi màu nên, vì vậy phải dùng container
                Container(
                    height: 200,
                    width: double.infinity,
                    // full ngang màn hình
                    padding: EdgeInsets.only(bottom: 30),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Color.fromRGBO(238, 238, 238, 1),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            // Màu của bóng đổ
                            offset: Offset(0, 4),
                            // Độ dịch chuyển theo trục x và y
                            blurRadius: 4,
                            // Bán kính làm mờ bóng đổ
                            spreadRadius: 0, // Bán kính phân tán bóng đổ
                          )
                        ]),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      // used to align bottom center
                      child: Text(
                        "Mobile Store",
                        style: TextStyle(
                          fontSize: 40,
                          //fontFamily: ,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )),

                Container(
                    width: 300,
                    height: 480,
                    child: Column(children: [
                      Container(
                        padding: const
                        EdgeInsets.only(
                            left: 40, top: 60, right: 40, bottom: 20),
                        child: const Text("REGISTER",
                            style: TextStyle(
                              fontSize: 30,
                              //fontFamily:
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(91, 184, 93, 1),
                            )),
                      ),

                      TextFormField(
                        controller: _nameController,
                        decoration:  const InputDecoration(
                          hintText: 'User Name',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 15,
                              top: 5,
                              bottom: 5), // Viền xung quanh trường nhập liệu
                        ),
                        onChanged: (value) {
                          // Xử lý sự kiện khi giá trị nhập liệu thay đổi
                          print('Giá trị nhập liệu: $value');
                        },
                      ),

                      SizedBox(height: 12),

                      TextFormField(
                        controller: _emailController,
                        decoration: const  InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 15,
                              top: 5,
                              bottom: 5), // Viền xung quanh trường nhập liệu
                        ),
                        onChanged: (value) {
                          // Xử lý sự kiện khi giá trị nhập liệu thay đổi
                          print('Giá trị nhập liệu: $value');
                        },
                      ),

                      SizedBox(height: 12),

                      TextFormField(
                        controller: _fullnameController,
                        decoration: const  InputDecoration(
                          hintText: 'Full Name',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 15,
                              top: 5,
                              bottom: 5), // Viền xung quanh trường nhập liệu
                        ),
                        onChanged: (value) {
                          // Xử lý sự kiện khi giá trị nhập liệu thay đổi
                          print('Giá trị nhập liệu: $value');
                        },
                      ),

                      SizedBox(height: 12),

                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 15,
                              top: 5,
                              bottom: 5), // Viền xung quanh trường nhập liệu
                        ),
                        onChanged: (value) {
                          // Xử lý sự kiện khi giá trị nhập liệu thay đổi
                          print('Giá trị nhập liệu: $value');
                        },
                      ),

                      SizedBox(height: 12),

                      TextFormField(
                        controller: _repeatpasswordController,

                        decoration: const InputDecoration(
                          hintText: 'Repeat password',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 15,
                              top: 5,
                              bottom: 5), // Viền xung quanh trường nhập liệu
                        ),
                        onChanged: (value) {
                          // Xử lý sự kiện khi giá trị nhập liệu thay đổi
                          print('Giá trị nhập liệu: $value');
                        },
                      ),

                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          _register();
                          print('Đăng ký thành công!');
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(300, 46)),
                          // Kích thước tối thiểu (rộng x cao)
                          backgroundColor: MaterialStateProperty.resolveWith<
                              Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromRGBO(91, 184, 93,
                                    1); // Màu nền khi nút được nhấn
                              }
                              return const Color.fromRGBO(
                                  91, 184, 93, 1); // Màu nền khi bình thường
                            },
                          ),
                        ),
                        child: const Text('Sign Up', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)
                        ),
                      ),


                    ])),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Login', style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                )
              ])));
  }

  Future<void> _register() async {
    //get data from form
    final username = _nameController.text;
    final fullname = _fullnameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    final body = jsonEncode({
      "email": email,
      "password": password,
      "fullName": fullname,
      "gender": "0",
      "birthDay": "20-03-2003",
      "authProvider": "null"
    });

    const url = "http://45.117.170.206:60/apis/user/";
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: body, headers:  {"Content-Type": "application/json"});
    print(response.body);
  }
}