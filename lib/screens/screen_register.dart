import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_store_app/screens/screen_login.dart';
import '../repo/user_repo.dart';
import '../widget/bottom_navigation.dart';

class ScreenRegister extends StatefulWidget {
  ScreenRegister({Key? key}) : super(key: key);

  @override
  _ScreenRegisterState createState() {
    return _ScreenRegisterState();
  }
}

class _ScreenRegisterState extends State<ScreenRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatpasswordController = TextEditingController();
  bool passwordsMatch = true;
  bool _isEmailValid = true;

  bool isEmailValid(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkPasswords() {
    String password1 = passwordController.text;
    String password2 = repeatpasswordController.text;

    setState(() {
      passwordsMatch = (password1 == password2);
    });
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
                    height: 493,
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
                        controller: nameController,
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

                      SizedBox(height: 13),

                      TextFormField(
                        controller: emailController,
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
                      SizedBox(height: 4),

                      if( _isEmailValid == false)
                        Text("Email isn't valid", style: TextStyle(color: Colors.red, fontSize: 10)),

                      SizedBox(height: 7),

                      TextFormField(
                        controller: fullnameController,
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

                      SizedBox(height: 13),

                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
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

                      SizedBox(height: 13),

                      TextFormField(
                        controller: repeatpasswordController,
                        obscureText: true,
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

                      SizedBox(height: 5),

                      if(passwordsMatch == false)
                        Text("Password doesn't match previous entry", style: TextStyle(color: Colors.red, fontSize: 10)),

                      SizedBox(height: 4),

                      ElevatedButton(
                        onPressed: () async {
                          var is_error = false;


                          if(nameController.text.trim() == "") {
                            is_error = true;
                          }

                          if(emailController.text.trim() == "") {
                            is_error = true;
                          }

                          if(fullnameController.text.trim() == "") {
                            is_error = true;
                          }

                          if(passwordController.text.trim() == "") {
                            is_error = true;
                          }
                          if(repeatpasswordController.text.trim() == "") {
                            is_error = true;
                          }

                          if (is_error == true){
                            showFillInAllDialog();
                          } else {
                            checkPasswords();
                            _isEmailValid = isEmailValid(emailController.text);
                            if (passwordsMatch == true && _isEmailValid == true)  {
                              final user_api = new UserApi();
                              var response = await user_api.register(emailController.text, passwordController.text, fullnameController.text);

                              if (response == 201) {
                                showRegisterSuccessDialog();
                                print('Đăng ký thành công!');

                              } else {
                                if (response == 409) {
                                  showRegisterDuplicateDialog();
                                } else {
                                  showRegisterFailedDialog();
                                }
                              };
                            }

                          }
                          print('Đăng ký thành công!');
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(300, 40)),
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
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScreenLogin(),
                          ));
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

  void showFillInAllDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please fill in all fields'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenRegister(),
                ));
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showRegisterSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register success!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenLogin(),
                ));
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showRegisterDuplicateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email still exist'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenRegister(),
                ));
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showRegisterFailedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Internal Server Error'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenRegister(),
                ));
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

}