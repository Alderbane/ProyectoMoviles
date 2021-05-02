part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {
  @override
  List<Object> get props => [];
}

class CalendarEditState extends CalendarState {
  @override
  List<Object> get props => [];
}
class CalendarLoadingState extends CalendarState {
  @override
  List<Object> get props => [];
}

class CalendarLoadedState extends CalendarState {
  final List eventos;

  CalendarLoadedState({@required this.eventos});
  @override
  List<Object> get props => [eventos];
}

class CalendarErrorState extends CalendarState {
  final String errorMsg;

  CalendarErrorState({@required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
