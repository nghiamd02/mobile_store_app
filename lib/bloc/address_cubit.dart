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

  Future<void> createAddress(Address address) async {
    emit(LoadingAddressState());
    try {
      await _addressRepository.createAddress(address);
      getAllAddresses();
    } catch (e) {
      emit(FailureAddressState(e.toString()));
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

  Future<void> updateAddress(Address address) async {
    emit(LoadingAddressState());
    try {
      await _addressRepository.updateAddress(address);
      getAllAddresses();
    } catch (e) {
      emit(FailureAddressState(e.toString()));
    }
  }
}
