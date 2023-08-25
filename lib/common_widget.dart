import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showForgotPasswordEmail(BuildContext context) {
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
                              showForgotPasswordOtp(context);// Handle submit logic here

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
                              showForgotPasswordCreatNew(context)// Handle submit logic here
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

void showForgotPasswordCreatNew(BuildContext context) {
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