import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store_app/bloc/state/review_state.dart';
import 'package:mobile_store_app/models/review.dart';

import '../repo/review_repo.dart';

class ReviewCubit extends Cubit<ReviewState>{
  final ReviewRepository _repository;

  ReviewCubit (this._repository) :super(InitialReviewState());

  Future<void> createReview(Content content) async{
    emit(LoadingReviewState());
    try{
      var result = await _repository.createReview(content);
      emit(SuccessSubmitReviewState(result));
    }catch(e){
      emit(FailureReviewState(e.toString()));
    }
  }

  Future<void> getAllReviewsById(int no, int limit, int id) async{
    emit(LoadingReviewState());
    try{
      var result = await _repository.getAllPromotionsById(no, limit, id);
      if(result.contents.isEmpty){
        emit(NoDataReviewState());
      }
      emit(SuccessLoadingReviewState(result));
    }catch(e){
      emit(FailureReviewState(e.toString()));
    }
  }
}