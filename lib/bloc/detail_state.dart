import '../models/product.dart';

abstract class DetailState {}

class InitDetailState extends DetailState {}

class LoadingDetailState extends DetailState {}

class ErrorDetailState extends DetailState {
  final String message;
  ErrorDetailState(this.message);
}

class ResponseRelatedState extends DetailState {
  final List<RelatedProduct> products;
  ResponseRelatedState(this.products);
}

class ResponseDetailState extends DetailState {
  final Product product;
  ResponseDetailState(this.product);
}
