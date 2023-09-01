class Promotion {
  final int id;
  final String discountCode;
  final double totalPurchase;
  final int discount;
  final double maxGet;
  final String expireDate;
  final bool campaign;
  final bool status;

  Promotion({
    required this.id,
    required this.discountCode,
    required this.totalPurchase,
    required this.discount,
    required this.maxGet,
    required this.expireDate,
    required this.campaign,
    required this.status,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'],
      discountCode: json['discountCodeDTO'],
      totalPurchase: json['totalPurchaseDTO'],
      discount: json['discountDTO'],
      maxGet: json['maxGetDTO'],
      expireDate: json['expireDateDTO'],
      campaign: json['campagnDTO'],
      status: json['statusDTO'],
    );
  }
}

class ApiResponse {
  final List<Promotion> contents;
  final int totalPages;
  final int totalItems;
  final int limit;
  final int no;
  final bool first;
  final bool last;

  ApiResponse({
    required this.contents,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
    required this.no,
    required this.first,
    required this.last,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> contentsJson = json['contents'];

    List<Promotion> contents = contentsJson
        .map((dynamic contentJson) => Promotion.fromJson(contentJson))
        .toList();

    return ApiResponse(
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
