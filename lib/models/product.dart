class Product {
  final String? name;

  Product({this.name});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
    );
  }
}
