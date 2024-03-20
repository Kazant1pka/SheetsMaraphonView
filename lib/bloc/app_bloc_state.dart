part of 'app_bloc_bloc.dart';

enum AppStatus { initial, loading, success, failure }

class AppBlocState extends Equatable {
  AppBlocState({
    this.status = AppStatus.initial,
    this.urlTable = '',
    this.nameEvent = '',
    DateTime? endsEvent,
  }) : endsEvent = endsEvent ?? DateTime(2024, 04, 20);

  final AppStatus status;
  final String urlTable;
  final String nameEvent;
  final DateTime endsEvent;

  AppBlocState copyWith({
    AppStatus? status,
    String? urlTable,
    String? nameEvent,
    DateTime? endsEvent,
  }) {
    return AppBlocState(
      status: status ?? this.status,
      urlTable: urlTable ?? this.urlTable,
      nameEvent: nameEvent ?? this.nameEvent,
      endsEvent: endsEvent ?? this.endsEvent,
    );
  }

  @override
  List<Object> get props => [status, urlTable, nameEvent, endsEvent];
}

final class AppBlocInitial extends AppBlocState {}
