import 'package:mobile_store_app/models/category.dart';
import 'package:mobile_store_app/models/manufacturer.dart';
import 'package:mobile_store_app/models/product_tech.dart';

class Product {
  final String? name;

  Product({this.name});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
    );
  }
}
