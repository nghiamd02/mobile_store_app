import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_store_app/models/product.dart';

class DetailRepository {
  Future<Product> getProductDetail(int productId) async {
    final url = 'http://45.117.170.206:60/apis/product/detail/$productId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final source = Utf8Decoder().convert(response.bodyBytes);
      final json = jsonDecode(source);
      return Product.fromJson(json);
    }

    throw Exception('Failed to load data ${response.statusCode}');
  }

  Future<List<RelatedProduct>> getRelatedProduct(int productId) async {
    final url = 'http://45.117.170.206:60/apis/product/related-product?productId=$productId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List json = jsonDecode(response.body);
      final result = json.map((e) => RelatedProduct.fromJson(e)).toList();
      return result;
    }

    throw Exception('Failed to load data ${response.statusCode}');
  }
}