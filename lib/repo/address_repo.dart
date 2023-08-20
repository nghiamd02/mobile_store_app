import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_store_app/models/address.dart';

class AddressRepository {
  static const addressUrl = "http://45.117.170.206:60/apis/address";

  static Future<List<Address>> getAllAddresses() async {
    final uri = Uri.parse(addressUrl);
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ2b3RpZW4xMjM0NUBnbWFpbC5jb20iLCJyb2xlcyI6W3siYXV0aG9yaXR5IjoiUm9sZV9DdXN0b21lciJ9XSwiaWF0IjoxNjkyNTM4NzE5LCJleHAiOjE2OTI1NTY3MTl9.tI3V97SuRBVar6cjpeJH2qYGIWbcmtdyYM4GNjySPSM"
    });
    if (response.statusCode == 200) {
      return _parseJsonList(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static List<Address> _parseJsonList(String body) {
    final parsedList = jsonDecode(body).cast<Map<String, dynamic>>();
    return parsedList.map<Address>((json) => Address.fromJson(json)).toList();
  }
}
