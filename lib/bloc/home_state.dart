import '../models/product.dart';

abstract class HomeState {}

class InitHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class ErrorHomeState extends HomeState {
  final String message;
  ErrorHomeState(this.message);
}

class ResponseHomeState extends HomeState {
  final List<Product> products;
  ResponseHomeState(this.products);
}
