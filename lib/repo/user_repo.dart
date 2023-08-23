import 'dart:convert';
import 'package:http/http.dart' as http;
import '../repo/constant_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class UserApi {
  final _storage = const FlutterSecureStorage();
  Future<int> login(String username, String password) async {
    final body = jsonEncode({
      "email": username,
      "password": password,
    });

    const url = "$APIURL/login/";
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: body, headers:  {"Content-Type": "application/json"});
    if(response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data);
      await saveUserInfo(data['token'], username);
    }

    return response.statusCode;

  }

  Future<int> register(String email, String password, String fullname) async {

    final body = jsonEncode({
      "email": email,
      "password": password,
      "fullName": fullname,
      "gender": "0",
      "birthDay": "20-03-2003",
      "authProvider": "null"
    });

    const url = "$APIURL/user/";
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: body, headers:  {"Content-Type": "application/json"});
    print(response.body);
    return response.statusCode;
  }



  saveUserInfo(token, username) async {
    await _storage.write(key: "token", value: token,);
    await _storage.write(key: "username", value: username,);
  }

  void logout() async {
    await _storage.delete(key: "username",);
    await _storage.delete(key: "token");
  }
}