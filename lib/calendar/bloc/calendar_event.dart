part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends CalendarEvent {
  @override
  List<Object> get props => [];
}

class EditEvent extends CalendarEvent {
  @override
  List<Object> get props => [];
}

class SaveEvent extends CalendarEvent {
  final Evento evento;

  SaveEvent({@required this.evento});

  @override
  List<Object> get props => [evento];
}

class UpdateEvent extends CalendarEvent {
  final Evento evento;

  UpdateEvent({@required this.evento});

  @override
  List<Object> get props => [evento];
}

class DownloadEvent extends CalendarEvent {
  @override
  List<Object> get props => [];
}
