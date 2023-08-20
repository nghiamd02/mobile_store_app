
import '../models/promotion.dart';

abstract class PromotionState{}

class InitialPromotionState extends PromotionState{}

class LoadingPromotionState extends PromotionState{}

class FailurePromotionState extends PromotionState{
  final String errorMessage;

  FailurePromotionState(this.errorMessage);
}

class SuccessLoadingPromotionState extends PromotionState{
  final ApiResponse apiResponse ;

  SuccessLoadingPromotionState(this.apiResponse);
}

class SuccessSubmitPromotionState extends PromotionState{
  final Promotion promotionData ;

  SuccessSubmitPromotionState(this.promotionData);
}

class SuccessDeletePromotionState extends PromotionState{
  final String deleteMessage ;

  SuccessDeletePromotionState(this.deleteMessage);
}

