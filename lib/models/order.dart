import 'package:mobile_store_app/models/product.dart';
import 'package:mobile_store_app/models/status.dart';

class Order {
  int? id;
  double? total;
  String? receiveDate;
  List<Product>? productList;
  Status? status;
  int? addressId;
  int? quantity;

  Order({this.id, this.total, this.receiveDate, this.productList, this.status});
}
