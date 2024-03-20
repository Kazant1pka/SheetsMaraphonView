part of 'app_bloc_bloc.dart';

sealed class AppBlocEvent extends Equatable {
  const AppBlocEvent();

  @override
  List<Object> get props => [];
}

final class InitialValueEvent extends AppBlocEvent {
  const InitialValueEvent();
}

final class EditNameChanged extends AppBlocEvent {
  const EditNameChanged(this.nameEvent);

  final String nameEvent;

  @override
  List<Object> get props => [nameEvent];
}

final class EditDateChanged extends AppBlocEvent {
  const EditDateChanged(this.endsEvent);

  final DateTime endsEvent;

  @override
  List<Object> get props => [endsEvent];
}

final class EditTodoSubmitted extends AppBlocEvent {
  const EditTodoSubmitted();
}
