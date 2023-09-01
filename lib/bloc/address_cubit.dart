import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store_app/bloc/state/address_state.dart';
import 'package:mobile_store_app/models/address.dart';
import 'package:mobile_store_app/repo/address_repo.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository _addressRepository;

  AddressCubit(this._addressRepository) : super(InitialAddressState());

  Future<void> getAllAddresses() async {
    emit(LoadingAddressState());
    try {
      var result = await _addressRepository.getAllAddresses();
      emit(SuccessLoadingAddress(result));
    } catch (e) {
      emit(FailureAddressState(e.toString()));
    }
  }

  Future<String> createAddress(Address address) async {
    int statusCode = await _addressRepository.createAddress(address);
    if (statusCode == 201) {
      return "Successfull Added";
    } else {
      return "Failed to add";
    }
  }

  Future<void> deleteAddress(String id) async {
    emit(LoadingAddressState());
    try {
      await _addressRepository.deleteAddress(id);
      getAllAddresses();
    } catch (e) {
      emit(FailureAddressState(e.toString()));
    }
  }

  Future<int> updateAddress(Address address) async {
    int statusCode = await _addressRepository.updateAddress(address);
    return statusCode;
  }
}
