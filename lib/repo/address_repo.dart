import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_store_app/models/address.dart';
import 'package:mobile_store_app/repo/user_repo.dart';

class AddressRepository {
  static const addressUrl = "http://45.117.170.206:60/apis/address";
  final UserRepository _userRepository = UserRepository();

  Future<List<Address>> getAllAddresses() async {
    final uri = Uri.parse(addressUrl);
    final userToken = await _userRepository.getToken();
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $userToken"
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

  Future<int> createAddress(Address address) async {
    final uri = Uri.parse(addressUrl);
    final userToken = await _userRepository.getToken();

    final body = jsonEncode({
      "location": address.location,
      "type": address.type,
      "phoneReceiver": address.phoneReceiver,
      "nameReceiver": address.nameReceiver,
    });

    final response = await http.post(uri, body: body, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $userToken",
    });

    return response.statusCode;
  }

  Future<void> deleteAddress(String id) async {
    final url = "$addressUrl/$id";
    final userToken = await _userRepository.getToken();
    final uri = Uri.parse(url);

    final response = await http.delete(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer $userToken"});
    print(response.statusCode);

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception("Failed to delete an address");
    }
  }

  Future<int> updateAddress(Address updatedAddress) async {
    final url = "$addressUrl/update-address/${updatedAddress.id}";

    final userToken = await _userRepository.getToken();
    final uri = Uri.parse(url);

    final body = jsonEncode({
      "location": updatedAddress.location,
      "phoneReceiver": 012345678,
      "nameReceiver": updatedAddress.nameReceiver,
      "defaults": updatedAddress.defaults,
      "type": updatedAddress.type
    });

    final response = await http.put(uri, body: body, headers: {
      HttpHeaders.authorizationHeader: "Bearer $userToken",
      HttpHeaders.contentTypeHeader: "application/json",
    });

    return response.statusCode;
  }

  Future<Address> getAddressById(Address address) async {
    final url = "$addressUrl/${address.id}";
    final userToken = await _userRepository.getToken();
    final uri = Uri.parse(url);

    final response = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer $userToken"});

    if (response.statusCode == 200) {
      return Address.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to get an address");
    }
  }
}
