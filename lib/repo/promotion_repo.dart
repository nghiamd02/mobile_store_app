import 'package:http/http.dart' as http;

import 'dart:convert';

import '../models/promotion.dart';

class PromotionRepository{
  static const String urlRead = "http://45.117.170.206:60/apis/promotion";

  static const int statusCode200 = 200;

  static const String bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdW5yaXNlMjQxMTk2QGdtYWlsLmNvbSIsInJvbGVzIjpbeyJhdXRob3JpdHkiOiJSb2xlX0N1c3RvbWVyIn1dLCJpYXQiOjE2OTI1NDQ3OTgsImV4cCI6MTY5MjU2Mjc5OH0.gZIcEXrRnehJjtV0IMepIWskhygRoIFBq3chxpv683c";

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