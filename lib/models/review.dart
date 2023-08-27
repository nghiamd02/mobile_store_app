class Review {
  final String? user_name;
  final int? product_id;
  final String? comment;
  final int? rating;
  final bool? status;

  Review({
   this.user_name,
   this.product_id,
   this.comment,
   this.rating,
   this.status
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user_name: json["user_name"],
      product_id: json["product_id"],
      comment: json["comment"],
      rating: json["rating"],
      status: json["status"],
    );
  }
}
