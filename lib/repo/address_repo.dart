import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_store_app/models/address.dart';

class AddressRepository {
  static const addressUrl = "http://45.117.170.206:60/apis/address";

  Future<List<Address>> getAllAddresses() async {
    final uri = Uri.parse(addressUrl);
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ2b3RpZW4xMjM0NUBnbWFpbC5jb20iLCJyb2xlcyI6W3siYXV0aG9yaXR5IjoiUm9sZV9DdXN0b21lciJ9XSwiaWF0IjoxNjkyOTQzMTIwLCJleHAiOjE2OTI5NjExMjB9.dw8iYt6fhK4LGMyk-Nm1QS8fUdwymE8lZ5cb0kBBa54"
    });
    if (response.statusCode == 200) {
      return _parseJsonList(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Address> _parseJsonList(String body) {
    final parsedList = jsonDecode(body).cast<Map<String, dynamic>>();
    return parsedList.map<Address>((json) => Address.fromJson(json)).toList();
  }

  void createAddress(Address address) async {
    final uri = Uri.parse(addressUrl);
    final body = {
      "location": address.location,
      "phoneReceiver": address.phoneReceiver,
      "nameReceiver": address.nameReceiver,
      "defaults": address.defaults
    };

    final response = await http.post(uri, body: body);
  }
}
