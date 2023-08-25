import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store_app/repo/user_repo.dart';
import 'package:mobile_store_app/screens/screen_login.dart';

void showForgotPasswordEmail(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0)),
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
                        controller: emailController,
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
                            onPressed: () async {
                              final user_api = new UserRepository();
                              var response = await user_api.sendEmail(
                                 emailController.text);

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
              ],),
          )
      );
    },
  );
}

void showForgotPasswordOtp(BuildContext context) {
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatpasswordController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0)),
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

                Text("Please confirm it and enter your new password",  textAlign: TextAlign.center),

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
                        controller: passwordController,

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
                            controller: repeatpasswordController,


                            decoration: InputDecoration(
                          hintText: 'Reapeat Password',
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
                            onPressed: () async {
                              final user_api = new UserRepository();
                              var response = await user_api.resetPassword(
                              otpController.text, passwordController.text,);
                              print(response);
                              if (response == 200) {
                                showChangePassSuccessDialog(context);
                               // Handle submit logic here
                              } else {
                                showChangePassFailedDialog(context);

                                // Handle submit logic here
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