import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store_app/bloc/detail_state.dart';
import 'package:mobile_store_app/models/address.dart';
import 'package:mobile_store_app/models/product.dart';
import 'package:mobile_store_app/repo/address_repo.dart';
import 'package:mobile_store_app/repo/cart_repo.dart';
import '../repo/detail_repo.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository? _cartRepository;

  CartCubit(this._cartRepository) : super(InitCartState());

  Future<void> fetchAddress() async {
    emit(LoadingCartState());
    try {
      final response = await _cartRepository?.getAllAddresses();
      if (response != null) {
        emit(ResponseAddressState(response!));
      }
    } catch (e) {
      emit(ErrorCartState(e.toString()));
    }
  }

  Future<void> loadCart() async {
    emit(LoadingCartState());
    try {
      final response = _cartRepository?.showUniqueValue();
      if (response != null) {
        emit(ResponseCart(response));
      }
    } catch (e) {
      emit(ErrorCartState(e.toString()));
    }
  }
}
