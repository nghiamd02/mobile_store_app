import 'package:flutter/cupertino.dart';
import 'package:mobile_store_app/models/color.dart';
import 'package:mobile_store_app/models/product.dart';

import 'memory.dart';

class Cart {
  Product? product;
  Memory? memory;
  ColorDTO? color;

  Cart({
    this.product,
    this.memory,
    this.color
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = new Map();
    m['product'] = product;
    m['memory'] = memory;
    m['color'] = color;
    return m;
  }

  Cart fromJson(Map<String, dynamic> m) {
    return Cart(
      product: m['product'],
      memory: m['memory'],
      color: m['color'],
    );
  }
}