import 'package:mobile_store_app/models/color.dart';
import 'package:mobile_store_app/models/image.dart';
import 'package:mobile_store_app/models/memory.dart';
import 'package:mobile_store_app/models/product_tech.dart';
import 'package:mobile_store_app/models/review.dart';
import 'package:mobile_store_app/models/seri.dart';

import 'category.dart';
import 'manufacturer.dart';

class Product {
  final int? id;
  final String? name;
  final Category? category;
  final Manufacturer? manufacturer;
  final String? description;
  final double? price;
  final int? stocks;
  final bool? status;
  final int? views;
  final double? star;
  final List<ProductTech>? productTechs;
  final List<Seri>? series;
  final List<ColorDTO>? colors;
  final List<Memory>? memories;
  final List<Review>? reviews;
  final List<Image>? images;

  Product({
      this.id,
      this.category,
      this.manufacturer,
      this.description,
      this.price,
      this.stocks,
      this.status,
      this.views,
      this.star,
      this.productTechs,
      this.series,
      this.colors,
      this.memories,
      this.reviews,
      this.images,
      this.name });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        category: Category.fromJson(json["categoriesDTO"]),
        manufacturer: Manufacturer.fromJson(json["manufacturerDTO"]),
        description: json["description"],
        price: json["price"],
        stocks: json["stocks"],
        status: json["status"],
        views: json["views"],
        star: json["star"],
        productTechs: List<ProductTech>.from(json["productTechDTOs"].map((e) => ProductTech.fromJson(e)).toList()),
        series: List<Seri>.from(json["seriDTOs"].map((e) => Seri.fromJson(e)).toList()),
        colors: List<ColorDTO>.from(json["colorDTOs"].map((e) => ColorDTO.fromJson(e)).toList()),
        memories: List<Memory>.from(json["memoryDTOs"].map((e) => Memory.fromJson(e)).toList()),
        reviews: List<Review>.from(json["reviewDTOs"].map((e) => Review.fromJson(e)).toList()),
        images: List<Image>.from(json["imageDTOs"].map((e) => Image.fromJson(e)).toList()),
        name: json["name"]);
  }
}

class RelatedProduct {
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final List<Image>? images;

  RelatedProduct({
    this.id,
    this.description,
    this.price,
    this.images,
    this.name });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
        id: json["id"],
        description: json["description"],
        price: json["price"],
        images: List<Image>.from(json["imageDTOs"].map((e) => Image.fromJson(e)).toList()),
        name: json["name"]);
  }
}
