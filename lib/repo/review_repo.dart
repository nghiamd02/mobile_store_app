import 'dart:convert';

import 'package:mobile_store_app/models/review.dart';

import 'package:http/http.dart' as http;

class ReviewRepository {
  static const String url = "http://45.117.170.206:60/apis/review";

  static const int statusCode201 = 201;

  static const int statusCode200 = 200;

  static const String bearerToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdW5yaXNlMjQxMTk2QGdtYWlsLmNvbSIsInJvbGVzIjpbeyJhdXRob3JpdHkiOiJSb2xlX0N1c3RvbWVyIn1dLCJpYXQiOjE2OTMzODUzMTQsImV4cCI6MTY5MzQwMzMxNH0.wxOsN0GoVZH7LRNyF1onXK7mjDf2RBunlWTpbnoz7-4";

  //create review
  Future<String> createReview(Content content) async {
  final uri = Uri.parse(url);
  final headers = {
    'Authorization': 'Bearer $bearerToken',
    'Content-Type': 'application/json', 
  };
  
  final requestBody = {
    'product_id': content.productId,
    'comment': content.comment,
    'rating': content.rating,
    'status': content.status,
  };

  
  final response = await http.post(
    uri,
    headers: headers,
    body: jsonEncode(requestBody), 
  );
  
  if (response.statusCode == statusCode201) {
    final decodedBody = jsonDecode(response.body);
    return decodedBody['message'] ?? '';
  }
  
  throw Exception('Failed to create review ${response.statusCode}');
}

//Get review by product_id
Future<ReviewResponse> getAllPromotionsById(int no, int limit, int idProduct) async {
    final uri = Uri.parse("$url/$idProduct?no=$no&limit=$limit");
    final response = await http.get(uri);

    if (response.statusCode == statusCode200) {
      return ReviewResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to load promotion data ${response.statusCode}');
  }

}