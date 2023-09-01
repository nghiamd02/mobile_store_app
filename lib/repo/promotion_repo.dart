import 'package:http/http.dart' as http;

import 'dart:convert';

import '../models/promotion.dart';

import 'package:mobile_store_app/repo/user_repo.dart';

class PromotionRepository {
  static const String urlRead = "http://45.117.170.206:60/apis/promotion";

  static const int statusCode200 = 200;

  final UserRepository _userRepository = UserRepository();

      

  //get all promotion
  Future<ApiResponse> getAllPromotions(int no, int limit) async {
    final userToken = await _userRepository.getToken();
    final uri = Uri.parse("$urlRead?no=$no&limit=$limit");
    final headers = {'Authorization': 'Bearer $userToken'};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == statusCode200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to load promotion data ${response.statusCode}');
  }
}
