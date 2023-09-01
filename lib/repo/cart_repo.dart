import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_store_app/models/cart.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_store_app/repo/user_repo.dart';
import 'dart:convert';
import '../models/address.dart';
import 'package:localstorage/localstorage.dart';

class CartRepository {
  final UserRepository _userRepository = UserRepository();
  static const addressUrl = "http://45.117.170.206:60/apis/address";
  final LocalStorage storage = LocalStorage('cart.json');
  static List<Cart> carts = [];

  _saveToStorage() {
    storage.setItem('carts', carts.map((item) {
      return item.toJson();
    }).toList());
  }

  addProduct(Cart cart) {
    carts += [cart];
    _saveToStorage();
  }

  removeProduct(Cart cart) {
    carts.remove(cart);
    _saveToStorage();
  }

  removeWhereProduct(Cart cart) {
    carts.removeWhere((element) => element == cart);
    _saveToStorage();
  }

  removeAllProduct() {
    carts = [];
    _saveToStorage();
  }

  int countProduct(Cart cart) {
    int count = 0;
    for (final item in carts) {
      if (item == cart) {
        count += 1;
      }
    }
    return count;
  }

  double getSumPrice() {
    double sum = 0;
    for (final item in carts) {
      sum += item.product?.price ?? 0;
    }
    return sum;
  }

  List<Cart> showUniqueValue() {
    final uniqueList = <Cart>[];
    for (final item in carts) {
      if (!uniqueList.contains(item)) {
        uniqueList.add(item);
      }
    }
    return uniqueList;
  }

  Future<List<Address>> getAllAddresses() async {
    const addressUrl = "http://45.117.170.206:60/apis/address";
    const bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ2b3RpZW4xMjM0NUBnbWFpbC5jb20iLCJyb2xlcyI6W3siYXV0aG9yaXR5IjoiUm9sZV9DdXN0b21lciJ9XSwiaWF0IjoxNjkzNDg2NzQxLCJleHAiOjE2OTM1MDQ3NDF9.ZRXjMJDa4KacxujEW7SwE1u0dBzoGiH3mpdPJV9eLI8";
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