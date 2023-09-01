import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../repo/constant_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final _storage = const FlutterSecureStorage();
  Map<String, dynamic>? currentUser;
  Future<int> login(String username, String password) async {
    final body = jsonEncode({
      "email": username,
      "password": password,
    });
    const url = "$APIURL/login/";
    final uri = Uri.parse(url);
    final response = await http
        .post(uri, body: body, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      await saveUserInfo(data['token'], username, data['idUser'], password);
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
    final response = await http
        .post(uri, body: body, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 201) {
      await activeUser(email);
    }
    return response.statusCode;
  }

  Future<int> sendEmail(String? email) async {
    final url = "$APIURL/mail/forgot-password/$email";
    final uri = Uri.parse(url);
    final response =
        await get(uri, headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }

  Future<int> otpActive(String? otp) async {
    final url = "$APIURL/user/active-otp?activeOTP=$otp";
    final uri = Uri.parse(url);
    final response =
        await get(uri, headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }

  Future<int> resetPassword(String otp, String password) async {
    final body = jsonEncode({
      "otp": otp,
      "newPassword": password,
    });
    const url = "$APIURL/user/change-password-by-otp/";
    final uri = Uri.parse(url);
    final response = await http
        .post(uri, body: body, headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }

  Future<int> changePassword(String oldPassword, String newPassword) async {
    const url = "$APIURL/user/change-password-by-token";
    final uri = Uri.parse(url);
    final userToken = await getToken();
    final body =
        jsonEncode({"newPassword": newPassword, "oldPassword": oldPassword});

    final response = await http.put(uri, body: body, headers: {
      HttpHeaders.authorizationHeader: "Bearer $userToken",
      HttpHeaders.contentTypeHeader: "application/json"
    });

    if (response.statusCode == 200) {
      return 200;
    } else {
      throw Exception("Failed to change password");
    }
  }

  Future<int> activeUser(String? email) async {
    final url = "$APIURL/mail/active-user?email=$email";
    final uri = Uri.parse(url);
    final response =
        await get(uri, headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }

  saveUserInfo(token, username, idUser, password) async {
    await _storage.write(
      key: "token",
      value: token,
    );
    await _storage.write(
      key: "username",
      value: username,
    );
    await _storage.write(
      key: "idUser",
      value: idUser.toString(),
    );
    await _storage.write(key: "userPassword", value: password);
  }

  //added by Nghia
  saveUserPhoneNumber(String number) async {
    await _storage.write(key: "phoneNumber", value: number);
  }

  Future<String?> getUserPhoneNumber() async {
    String? result = await _storage.read(key: "phoneNumber");
    return result;
  }

  void logout() async {
    await _storage.delete(
      key: "username",
    );
    await _storage.delete(key: "token");
    await _storage.delete(key: "idUser");
  }

  getToken() async {
    String? val = await _storage.read(key: "token");
    return val.toString();
  }

  Future<String> getUsername() async {
    String? val = await _storage.read(key: "username");
    return val.toString();
  }

  getIdUser() async {
    String? val = await _storage.read(key: "idUser");
    return val.toString();
  }

  getUserPassword() async {
    String? val = await _storage.read(key: "userPassword");
    return val.toString();
  }

  Future<String> getUserFullName() async {
    final userId = await getIdUser();
    final user = await getUserById(userId);
    return user["fullName"];
  }

  //added by Nghia
  Future<Map<String, dynamic>> getUserById(String id) async {
    final url = "$APIURL/user/$id";
    final uri = Uri.parse(url);
    final userToken = await getToken();
    final response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: "Bearer $userToken",
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to find user");
    }
  }

  //add by Nghia
  Future<bool> updateUser(Map<String, dynamic> updateUser) async {
    final url = "$APIURL/user/${updateUser["id"]}";
    final uri = Uri.parse(url);
    final userToken = await getToken();
    final body = jsonEncode(updateUser);
    final response = await http.put(uri, body: body, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $userToken"
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update user information");
    }
  }

  Future<void> setCurrentUser() async {
    String userId = await getIdUser();

    currentUser = await getUserById(userId);
  }
}
