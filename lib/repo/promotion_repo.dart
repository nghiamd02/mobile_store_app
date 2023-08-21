import 'package:http/http.dart' as http;

import 'dart:convert';

import '../models/promotion.dart';

class PromotionRepository {
  static const String urlRead = "http://45.117.170.206:60/apis/promotion";

  static const int statusCode200 = 200;

  static const String bearerToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBnbWFpbC5jb20iLCJyb2xlcyI6W3siYXV0aG9yaXR5IjoiUm9sZV9BZG1pbiJ9XSwiaWF0IjoxNjkyNjA3ODk3LCJleHAiOjE2OTI2MjU4OTd9.MlhCF0Eql7RSuSEHRPXkdkD5XqmUPhhJmwg3CZcaQoo";

  //get all promotion
  Future<ApiResponse> getAllPromotions(int no, int limit) async {
    final uri = Uri.parse("$urlRead?no=$no&limit=$limit");
    final headers = {'Authorization': 'Bearer $bearerToken'};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == statusCode200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to load promotion data ${response.statusCode}');
  }
}
