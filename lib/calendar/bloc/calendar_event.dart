part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveEvent extends Equatable {
  final Evento event;

  SaveEvent({@required this.event});

  @override
  List<Object> get props => [event];
}
