import 'package:mobile_store_app/models/product.dart';
import 'package:mobile_store_app/models/status.dart';

class Order {
  int? id;
  int? idPromotion;
  double? total;
  String? receiveDate;
  String? paymentMethod;
  Product? product;
  Status? status;
  int? idAddress;
  int? quantity;

  Order(
      {this.id,
      this.total,
      this.receiveDate,
      this.product,
      this.status,
      this.idAddress,
      this.idPromotion,
      this.paymentMethod,
      this.quantity});

  factory Order.fromJson(Map<String, dynamic> json) {
    Status status = Status.fromJson(json["statusDTO"]);
    final jsonProduct = json["productOrderDTO"];
    Product product = Product(
        id: jsonProduct["id"],
        price: jsonProduct["price"],
        name: jsonProduct["name"],
        description: jsonProduct["description"],
        images: jsonProduct["image"]);

    return Order(
        id: json["id"],
        total: json["total"],
        receiveDate: json["receiveDate"],
        status: status,
        paymentMethod: json["paymentMethod"],
        idAddress: json["idAddress"],
        idPromotion: json["idPromotion"],
        quantity: json["quantity"]);
  }
}
