import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/home_screen.dart';
import 'package:mobile_store_app/screens/screen_register.dart';
import 'package:mobile_store_app/widget/bottom_navigation.dart';
// import '../common_widget.dart';
import '../repo/user_repo.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({Key? key}) : super(key: key);

  @override
  _ScreenLoginState createState() {
    return _ScreenLoginState();
  }
}

class _ScreenLoginState extends State<ScreenLogin> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool passwordMatch = true;



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
          child: Column(
        children: [
          // dùng Pading không thể thay đổi màu nên, vì vậy phải dùng container
          Container(
              height: 200,
              width: double.infinity,
              // full ngang màn hình
              padding: EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Color.fromRGBO(238, 238, 238, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25), // Màu của bóng đổ
                      offset: Offset(0, 4), // Độ dịch chuyển theo trục x và y
                      blurRadius: 4, // Bán kính làm mờ bóng đổ
                      spreadRadius: 0, // Bán kính phân tán bóng đổ
                    )
                  ]),
              child: Align(
                alignment:
                    Alignment.bottomCenter, // used to align bottom center
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
            height: 300,
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 40, top: 60, right: 40, bottom: 20),
                  child: Text("LOGIN",
                      style: TextStyle(
                        fontSize: 30,
                        //fontFamily:
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(91, 184, 93, 1),
                      )),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'User Name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(
                        left: 15,
                        top: 5,
                        bottom: 5), // Viền xung quanh trường nhập liệu
                  ),
                  onChanged: (value) {
                    // Xử lý sự kiện khi giá trị nhập liệu thay đổi
                    print('Giá trị nhập liệu: $value');
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.only(left: 15, top: 5, bottom: 5),
                  ),
                  onChanged: (value) {
                    print('Gía trị nhập liệu: $value');
                  },
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    final user_api = new UserRepository();
                    var response = await user_api.login(
                        _usernameController.text, _passwordController.text);
                    if (response == 201) {
                      _showLoginSuccessDialog();
                    } else {
                      _showLoginFailedDialog();
                    }
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        Size(300, 48)), // Kích thước tối thiểu (rộng x cao)
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Color.fromRGBO(
                              91, 184, 93, 1); // Màu nền khi nút được nhấn
                        }
                        return Color.fromRGBO(
                            91, 184, 93, 1); // Màu nền khi bình thường
                      },
                    ),
                  ),
                  child: Text('Login',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),

          Container(
              width: 330,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {
                        // Khi nút Checkbox được thay đổi
                        // value là true nếu được chọn, false nếu bỏ chọn
                        value!;
                      },
                      shape: CircleBorder(),
                    ),
                    Text('Remember me',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400)),
                  ]),
                  TextButton(
                    onPressed: () {
                      showForgotPasswordEmail(context);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue; // Màu chữ khi nút được nhấn
                          }
                          return Colors.blue; // Màu chữ khi bình thường
                        },
                      ),
                    ),
                    child: Text('Forgot password?',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400)),
                  )
                ],
              )),

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
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Text(
              "Sign in using",
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
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenRegister()));
                  },
                  child: Text('Resigter',
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.w400)),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  void _showLoginSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login success!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BottomNavigation(),
                ));
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showLoginFailedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login failed!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void checkPasswords(pwd1, pwd2) {
    setState(() {
      passwordMatch = (pwd1 == pwd2);
    });
  }
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordForgotController = TextEditingController();
  TextEditingController repeatpasswordForgotController = TextEditingController();

  void showForgotPasswordOtp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0)),
            ),
            // width

            child: Container(
              padding: EdgeInsets.all(0.0),
              width: 400,
              height: 360,
              child: Column(
                children: [
                  Container(
                      width: 400,
                      height: 50,
                      color: Color.fromRGBO(190, 190, 190, 0.7),
                      child: Center(
                        child: Text(
                          'FORGOT PASSWORD',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(height: 8),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Verify code has been sent to your phone number.",
                        textAlign:
                            TextAlign.center, // Căn giữa theo chiều ngang
                        softWrap: true, // Cho phép chữ tự động xuống hàng),
                      )),
                  Text("Please confirm it and enter your new password",
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
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
                            hintText: 'OPT',
                            hintStyle:
                                TextStyle(fontSize: 12.0, color: Colors.green),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            print('Gía trị nhập liệu: $value');
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                          controller: passwordForgotController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(fontSize: 12.0, color: Colors.green),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            print('Gía trị nhập liệu: $value');
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                          controller: repeatpasswordForgotController,
                          decoration: InputDecoration(
                            hintText: 'Reapeat Password',
                            hintStyle:
                                TextStyle(fontSize: 12.0, color: Colors.green),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            print('Gía trị nhập liệu: $value');
                          },
                        ),
                      ),
                    ),
                  ),
                  if (passwordMatch != true)
                    Text("Password and repeat not match",
                        style: TextStyle(color: Colors.red)),
                  SizedBox(height: 10),
                  Text(" OPT code expires later 59 seconds"),
                  SizedBox(height: 10),
                  Container(
                    width: 200,
                    height: 33,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 83,
                          height: 33,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 0, bottom: 0, top: 0),
                            child: TextButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 83,
                          height: 33,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 0, bottom: 0, top: 0),
                            child: TextButton(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              onPressed: () async {
                                var pwd1 = passwordForgotController.text;
                                var pwd2 = repeatpasswordForgotController.text;
                                if (pwd1 != pwd2) {
                                  setState(() {
                                    passwordMatch = false;
                                  });
                                  Navigator.pop(context);
                                  showForgotPasswordOtp(context);
                                } else {
                                  final user_api = new UserRepository();
                                  var response = await user_api.resetPassword(
                                    otpController.text,
                                    passwordForgotController.text,
                                  );
                                  print(response);
                                  if (response == 200) {
                                    showChangePassSuccessDialog(context);
                                    // Handle submit logic here
                                  } else {
                                    showChangePassFailedDialog(context);

                                    // Handle submit logic here
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  void showForgotPasswordEmail(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0)),
            ),
            child: Container(
              padding: EdgeInsets.all(0.0),
              width: MediaQuery.of(context).size.width - 10,
              height: 200,
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width - 10,
                      height: 50,
                      color: Color.fromRGBO(190, 190, 190, 0.7),
                      child: Center(
                        child: Text(
                          'FORGOT PASSWORD',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(height: 10),
                  Text(" Please enter your email"),
                  SizedBox(height: 10),
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
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'email',
                            hintStyle:
                                TextStyle(fontSize: 12.0, color: Colors.green),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            print('Gía trị nhập liệu: $value');
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 19),
                  Container(
                    width: 200,
                    height: 33,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 83,
                          height: 33,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 0, bottom: 0, top: 0),
                            child: TextButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 83,
                          height: 33,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 0, bottom: 0, top: 0),
                            child: TextButton(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              onPressed: () async {
                                final user_api = new UserRepository();
                                var response = await user_api
                                    .sendEmail(emailController.text);

                                if (response == 200) {
                                  Navigator.pop(context);
                                  showForgotPasswordOtp(
                                      context); // Handle submit logic here
                                } else {
                                  Navigator.pop(context);
                                  showForgotPasswordEmail(context);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  void showChangePassSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password change successfully!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenLogin(),
                ));
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showChangePassFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change password isn't successful!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenLogin(),
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
