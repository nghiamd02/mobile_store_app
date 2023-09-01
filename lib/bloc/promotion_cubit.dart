import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store_app/bloc/promotion_state.dart';
import 'package:mobile_store_app/repo/promotion_repo.dart';

class PromotionCubit extends Cubit<PromotionState>{
  final PromotionRepository _repository;

  PromotionCubit (this._repository) :super(InitialPromotionState());

  Future<void> getAllProfile(int no, int limit) async{
    emit(LoadingPromotionState());
    try{
      var result = await _repository.getAllPromotions(no, limit);
      emit(SuccessLoadingPromotionState(result));
    }catch(e){
      emit(FailurePromotionState(e.toString()));
    }
  }
}