import 'package:flutter/foundation.dart';

class ReviewResponse {
  final List<ContentReview> contents;
  final int totalPages;
  final int totalItems;
  final int limit;
  final int no;
  final bool first;
  final bool last;

  ReviewResponse({
    required this.contents,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
    required this.no,
    required this.first,
    required this.last,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> contentsJson = json['contents'];

    List<ContentReview> contents = contentsJson
        .map((dynamic contentJson) => ContentReview.fromJson(contentJson))
        .toList();

    return ReviewResponse(
      contents: contents,
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      limit: json['limit'],
      no: json['no'],
      first: json['first'],
      last: json['last'],
    );
  }
}

class ContentReview {
  final int? id;
  final String? userName;
  final int? productId;
  final String? comment;
  final int? rating;
  final bool? status;

  ContentReview(
      {this.id = 0,
      this.userName = 'Minh',
      required this.productId,
      required this.comment,
      required this.rating,
      required this.status});

  factory ContentReview.fromJson(Map<String, dynamic> json) {
    return ContentReview(
        id: json['id'],
        userName: json['user_name'],
        productId: json['product_id'],
        comment: json['comment'],
        rating: json['rating'],
        status: json['status']);
  }
}
