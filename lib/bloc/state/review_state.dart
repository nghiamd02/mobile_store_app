import 'package:mobile_store_app/models/review.dart';

abstract class ReviewState {}

class InitialReviewState extends ReviewState {}

class LoadingReviewState extends ReviewState {}

class FailureReviewState extends ReviewState {
  final String errorMessage;

  FailureReviewState(this.errorMessage);
}

class SuccessLoadingReviewState extends ReviewState {
  final ReviewResponse reviewResponse;

  SuccessLoadingReviewState(this.reviewResponse);
}

class SuccessSubmitReviewState extends ReviewState {
  final String successMessage;

  SuccessSubmitReviewState(this.successMessage);
}
