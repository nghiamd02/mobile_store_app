import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_store_app/models/address.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddressRepository {
  static const addressUrl = "http://45.117.170.206:60/apis/address";

  static const String bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ2b3RpZW4xMjM0NUBnbWFpbC5jb20iLCJyb2xlcyI6W3siYXV0aG9yaXR5IjoiUm9sZV9DdXN0b21lciJ9XSwiaWF0IjoxNjkzMDY0MjIxLCJleHAiOjE2OTMwODIyMjF9.wUTWUQ3ogZ1lSgt0MSk_ulTDPiuKPBPtWWhMcxPYyDM";

  Future<List<Address>> getAllAddresses() async {
    final uri = Uri.parse(addressUrl);
    final header = {'Authorization': 'Bearer $bearerToken'};
    final response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      List json = jsonDecode(response.body);
      final result = json.map((e) => Address.fromJson(e)).toList();
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
