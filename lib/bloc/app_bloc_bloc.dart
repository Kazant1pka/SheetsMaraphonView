import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maraphons/data/storage_repository.dart';
import 'package:maraphons/model/word.dart';

part 'app_bloc_event.dart';
part 'app_bloc_state.dart';

class AppBlocBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBlocBloc(this.storageRepository) : super(AppBlocInitial()) {
    on<InitialValueEvent>(_onInitialValue);
    on<EditNameChanged>(_onEditNameChanged);
    on<EditDateChanged>(_onEditDateChanged);
  }
  final StorageRepository storageRepository;

  void _onInitialValue(
    InitialValueEvent event,
    Emitter<AppBlocState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.loading));
    final dbLink = await storageRepository.getLink();
    final eventName = await storageRepository.getName();
    final endDate = await storageRepository.getDate() == Word.emptyDate
        ? DateTime.now().toString()
        : await storageRepository.getDate();
    emit(state.copyWith(
      status: AppStatus.success,
      urlTable: dbLink,
      nameEvent: eventName,
      endsEvent: DateTime.parse(endDate),
    ));
  }

  void _onEditNameChanged(
    EditNameChanged event,
    Emitter<AppBlocState> emit,
  ) async {
    emit(state.copyWith(nameEvent: event.nameEvent));
    await storageRepository.setName(event.nameEvent);
  }

  void _onEditDateChanged(
    EditDateChanged event,
    Emitter<AppBlocState> emit,
  ) async {
    emit(state.copyWith(endsEvent: event.endsEvent));
    await storageRepository.setDate(event.endsEvent.toString());
  }
}
