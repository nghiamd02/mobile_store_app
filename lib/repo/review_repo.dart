import 'dart:convert';

import 'package:mobile_store_app/models/review.dart';

import 'package:http/http.dart' as http;
import 'package:mobile_store_app/repo/user_repo.dart';

class ReviewRepository {
  static const String url = "http://45.117.170.206:60/apis/review";

  static const int statusCode201 = 201;

  static const int statusCode200 = 200;

  final UserRepository _userRepository = UserRepository();

  //create review
  Future<String> createReview(Content content) async {
  final userToken = await _userRepository.getToken();
  final uri = Uri.parse(url);
  final headers = {
    'Authorization': 'Bearer $userToken',
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