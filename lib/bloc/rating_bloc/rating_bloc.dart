import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:maraphons/controller/controller.dart';
import 'package:maraphons/data/storage_repository.dart';
import 'package:maraphons/model/form.dart';
import 'package:maraphons/model/word.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  RatingBloc(this.storageRepository) : super(RatingInitial()) {
    on<LoadUrl>(_onLoadUrl);
    on<ChangeUrl>(_onChangeUrl);
  }

  final StorageRepository storageRepository;

  StreamSubscription<List<FeedbackForm>>? _streamSubscription;

  Future<void> _onLoadUrl(
    LoadUrl event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingLoading());
    try {
      await loadData();
    } catch (e) {
      emit(RatingError(message: e.toString()));
    }
  }

  Future<void> _onChangeUrl(
    ChangeUrl event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingLoading());
    await storageRepository.setLink(event.updateLink);
    try {
      await loadData();
    } catch (e) {
      emit(RatingError(message: e.toString()));
    }
  }

  Future<void> loadData() async {
    final url = await storageRepository.getLink();
    if (url == Word.emptyLink) {
      throw Word.emptyLink;
    } else {
      _streamSubscription?.cancel();
      _streamSubscription =
          FormController(url: url).getStreamList().listen((event) {
        emit(RatingLoaded(data: event));
      });
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
