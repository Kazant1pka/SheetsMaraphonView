part of 'rating_bloc.dart';

@immutable
abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingError extends RatingState {
  RatingError({
    required this.message,
  });

  final String message;
}

class RatingLoaded extends RatingState {
  RatingLoaded({required this.data});

  final List<FeedbackForm> data;
}
