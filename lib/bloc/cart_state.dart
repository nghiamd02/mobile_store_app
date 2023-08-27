import 'package:mobile_store_app/models/cart.dart';

import '../models/address.dart';

abstract class CartState {}

class InitCartState extends CartState {}

class LoadingCartState extends CartState {}

class ErrorCartState extends CartState {
  final String message;
  ErrorCartState(this.message);
}

class ResponseAddressState extends CartState {
  final List<Address> address;
  ResponseAddressState(this.address);
}

class ResponseCart extends CartState {
  final List<Cart> cart;
  ResponseCart(this.cart);
}

abstract class CounterState{}

class LoadingCounterState extends CounterState{}

class SuccessCounterState extends CounterState{
  int count = 0;
  SuccessCounterState(this.count);
}