import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store_app/bloc/detail_state.dart';
import 'package:mobile_store_app/models/product.dart';
import '../repo/detail_repo.dart';

class DetailCubit extends Cubit<DetailState> {
  final DetailRepository _detailRepository;

  DetailCubit(this._detailRepository) : super(InitDetailState());

  Future<Product> fetchProductDetail(int id) async {
    emit(LoadingDetailState());
    try{
      final response = await _detailRepository.getProductDetail(id);
      return ResponseDetailState(response).product;
    }
    catch (e) {
      emit(ErrorDetailState(e.toString()));
    }
    return Product();
  }

  Future<void> fetchRelatedProduct(int id) async {
    emit(LoadingDetailState());
    try{
      final response = await _detailRepository.getRelatedProduct(id);
      emit(ResponseRelatedState(response));
    }
    catch (e) {
      emit(ErrorDetailState(e.toString()));
    }
  }
}