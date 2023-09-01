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
  bool _isError = false;

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
                    height: 475,
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
                              final user_api = new UserRepository();
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
                  width: 320,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 128, // Chiều rộng tối đa
                        height: 0.5, // Chiều cao của đường kẻ
                        decoration: BoxDecoration(
                          color: Colors.grey, // Màu của đường kẻ
                        ),
                      ),
                      Text(
                        "or",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        width: 128, // Chiều rộng tối đa
                        height: 0.5, // Chiều cao của đường kẻ
                        decoration: BoxDecoration(
                          color: Colors.grey, // Màu của đường kẻ
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    "Register with",
                    style: TextStyle(
                        fontSize: 18,
                        //fontFamily:
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.facebook, // Tên của biểu tượng
                        color: Colors.blue, // Màu của biểu tượng
                        size: 35, // Kích thước của biểu tượng
                      ),
                      Icon(
                        Icons.g_mobiledata_sharp, // Tên của biểu tượng
                        color: Colors.red, // Màu của biểu tượng
                        size: 35, // Kích thước của biểu tượng
                      )
                    ],
                  ),
                ),


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
                showActiveUser(context);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => ScreenLogin(),
                // ));
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

  void showActiveUser(BuildContext context ) {
    TextEditingController otpController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Container(
              padding: EdgeInsets.all(0.0),
              width: 340,
              height: 230,

              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Màu của đường viền
                          width: 1.0,          // Độ dày của đường viền
                        ),
                      ),
                      width: 340,
                      height: 50,
                      //color: Color.fromRGBO(190, 190, 190, 0.7),
                      child: Center(
                        child: Text(
                          'VERIFIED EMAIL',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      )
                  ),

                  SizedBox(height: 12),

                  Center(
                    child: Container(
                      width: 240,
                      height: 35,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: otpController,
                          decoration: InputDecoration(
                            hintText: '',
                            hintStyle: TextStyle(fontSize: 12.0, color: Colors.green),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            print('Gía trị nhập liệu: $value');
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 2),

                  Center(
                    child: Container(
                      width: 240,
                      height: 25,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("0/4", style: TextStyle(color: Colors.grey),),
                      ),
                    ),
                  ),

                  if (_isError == true)
                      Text( "Active user isn't successful"),

                  Center(
                    child: Container(
                      width: 240,
                      height: 25,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("Sent OTP via Email: 59s"),
                      ),
                    ),
                  ),

                  SizedBox(height: 8),

                  Container(
                    width: 200,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 0, right: 0, bottom: 0,top: 0),
                            child: TextButton(
                              child: Text('Verified Email', style: TextStyle(fontSize:15, color: Colors.white, fontWeight: FontWeight.w400),),
                              onPressed: () async {
                                final user_api = new UserRepository();
                                var response = await user_api.otpActive(otpController.text);
                                if ( response == 200 ){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ScreenLogin(),
                                  ));
                                } else {
                                  setState(() {
                                    _isError = true;
                                  });
                                  Navigator.of(context).pop();
                                  showActiveUser(context);
                                }
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],),
            )
        );
      },
    );
  }
}