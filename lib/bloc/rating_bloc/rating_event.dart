part of 'rating_bloc.dart';

@immutable
abstract class RatingEvent {}

class LoadUrl extends RatingEvent {}

class ChangeUrl extends RatingEvent {
  ChangeUrl({required this.updateLink});

  final String updateLink;
}
