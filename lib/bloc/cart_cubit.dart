import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store_app/bloc/detail_state.dart';
import 'package:mobile_store_app/models/address.dart';
import 'package:mobile_store_app/repo/address_repo.dart';
import '../repo/detail_repo.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddressRepository _addressRepository;

  CartCubit(this._addressRepository) : super(InitCartState());

  Future<void> fetchAddress() async {
    emit(LoadingCartState());
    try{
      final response = await _addressRepository.getAllAddresses();
      emit(ResponseAddressState(response));
    }
    catch (e) {
      emit(ErrorCartState(e.toString()));
    }
  }
}