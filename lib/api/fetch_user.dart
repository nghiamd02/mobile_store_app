import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constant.dart';

class UserApi {
  Future<int> login(String username, String password) async {
    final body = jsonEncode({
      "email": username,
      "password": password,
    });

    const url = "$APIURL/login/";
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: body, headers:  {"Content-Type": "application/json"});
    print(response.body);
    return response.statusCode;

  }
}