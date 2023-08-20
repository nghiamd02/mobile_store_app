import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/screen_register.dart';

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
                  onPressed: () {
                    _login();

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
                      _showForgotPasswordEmail(context);
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

  Future<void> _login() async {
    //get data from form
    final username = _usernameController.text;
    final password = _passwordController.text;

    final body = jsonEncode({
      "email": username,
      "password": password,
    });

    const url = "http://45.117.170.206:60/apis/login/";
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: body, headers:  {"Content-Type": "application/json"});
    print(response.body);

    if (response.statusCode == 201) {
       _showLoginSuccessDialog();
    } else {
       _showLoginFailedDialog();
    }
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




}

void _showForgotPasswordEmail(BuildContext context) {
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
          height: 200,

          child: Column(
              children: [
                Container(
                  width: 300,
                  height: 50,
                  color: Color.fromRGBO(190, 190, 190, 0.7),
                  child: Center(
                    child: Text(
                      'FORGOT PASSWORD',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  )
                  ),

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
                    decoration: InputDecoration(
                    hintText: 'email',
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
                          padding: EdgeInsets.only(left: 0, right: 0, bottom: 0,top: 0),
                          child: TextButton(
                            child: Text('Cancel', style: TextStyle(fontSize:12,color: Colors.white, fontWeight: FontWeight.w300),),
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
                          padding: EdgeInsets.only(left: 0, right: 0, bottom: 0,top: 0),
                          child: TextButton(
                            child: Text('Confirm', style: TextStyle(fontSize:12, color: Colors.white, fontWeight: FontWeight.w300),),
                            onPressed: () {
                              Navigator.pop(context);
                              _showForgotPasswordOtp(context);// Handle submit logic here

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

void _showForgotPasswordOtp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Container(
            padding: EdgeInsets.all(0.0),
            width: 350,
            height: 260,

            child: Column(
              children: [
                Container(
                    width: 350,
                    height: 50,
                    color: Color.fromRGBO(190, 190, 190, 0.7),
                    child: Center(
                      child: Text(
                        'FORGOT PASSWORD',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    )
                ),

                SizedBox(height: 8),

                Container(
                  alignment: Alignment.center,
                    child: Text("Verify code has been sent to your phone number.",
                      textAlign: TextAlign.center, // Căn giữa theo chiều ngang
                      softWrap: true, // Cho phép chữ tự động xuống hàng),
                )),

                Text("Please confirm it"),

                SizedBox(height: 8),

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
                        decoration: InputDecoration(
                          hintText: 'OPT',
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

                SizedBox(height: 8),

                Text(" OPT code expires later 59 seconds"),

                SizedBox(height: 8),

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
                          padding: EdgeInsets.only(left: 0, right: 0, bottom: 0,top: 0),
                          child: TextButton(
                            child: Text('Cancel', style: TextStyle(fontSize:12,color: Colors.white, fontWeight: FontWeight.w300),),
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
                          padding: EdgeInsets.only(left: 0, right: 0, bottom: 0,top: 0),
                          child: TextButton(
                            child: Text('Confirm', style: TextStyle(fontSize:12, color: Colors.white, fontWeight: FontWeight.w300),),
                            onPressed: () {
                              Navigator.pop(context);
                              _showForgotPasswordCreatNew(context)// Handle submit logic here
                              ;
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

void _showForgotPasswordCreatNew(BuildContext context) {
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
                    width: 340,
                    height: 50,
                    color: Color.fromRGBO(190, 190, 190, 0.7),
                    child: Center(
                      child: Text(
                        'FORGOT PASSWORD',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    )
                ),

                SizedBox(height: 8),

                Text(" Please enter your new password"),

                SizedBox(height: 8),

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
                        decoration: InputDecoration(
                          hintText: 'Password',
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

                SizedBox(height: 8),

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
                        decoration: InputDecoration(
                          hintText: 'Repeat Password',
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

                SizedBox(height: 12),

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
                          padding: EdgeInsets.only(left: 0, right: 0, bottom: 0,top: 0),
                          child: TextButton(
                            child: Text('Cancel', style: TextStyle(fontSize:12,color: Colors.white, fontWeight: FontWeight.w300),),
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
                          padding: EdgeInsets.only(left: 0, right: 0, bottom: 0,top: 0),
                          child: TextButton(
                            child: Text('Confirm', style: TextStyle(fontSize:12, color: Colors.white, fontWeight: FontWeight.w300),),
                            onPressed: () {
                              // Handle submit logic here
                              Navigator.of(context).pop();
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