import 'package:http/http.dart' as http;
import 'package:mobile_store_app/repo/user_repo.dart';

import 'dart:convert';

import '../models/promotion.dart';

class PromotionRepository {
  UserRepository _userRepository = UserRepository();
  static const String urlRead = "http://45.117.170.206:60/apis/promotion";

  static const int statusCode200 = 200;

  //get all promotion
  Future<ApiResponse> getAllPromotions(int no, int limit) async {
    final uri = Uri.parse("$urlRead?no=$no&limit=$limit");
    final bearerToken = await _userRepository.getToken();
    final headers = {'Authorization': 'Bearer $bearerToken'};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == statusCode200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to load promotion data ${response.statusCode}');
  }
}
