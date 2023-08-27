import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_store_app/models/product.dart';

class HomeRepository {
  Future<List<Product>> getNew() async {
    const url = 'http://45.117.170.206:60/apis/product/new';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List json = jsonDecode(response.body);
      final result = json.map((e) => Product.fromJson(e)).toList();
      return result;
    }

    throw Exception('Failed to load data ${response.statusCode}');
  }
}