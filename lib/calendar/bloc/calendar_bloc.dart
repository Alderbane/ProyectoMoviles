import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendario/models/event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  static final CalendarBloc _booksRepository = CalendarBloc._internal();

  factory CalendarBloc() {
    return _booksRepository;
  }
  // CalendarBloc(){};
  CalendarBloc._internal() : super(CalendarInitial());

  Box _calendarBox = Hive.box("CalendarEvents");
  // CalendarBloc()  : super(CalendarInitial());

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is SaveEvent) {
      var calendarElements = [];
      calendarElements = _calendarBox.get("calendar", defaultValue: [
        Evento(
            fecha: DateTime(2021, 03, 20),
            titulo: "Entrega 2",
            descripcion: "ALABADO SEA EL SEÑOR QUESUS",
            hora: "Todo el día")
      ]);
      calendarElements.add(event.evento);
      await _calendarBox.put("calendar", calendarElements);
      print("Save event");
      yield CalendarLoadedState(eventos: calendarElements);
    } else if (event is LoadEvent) {
      List calendarElements = [];
      calendarElements.add(Evento(
        fecha: DateTime(2021, 03, 20),
        titulo: "Entrega 2",
        descripcion: "ALABADO SEA EL SEÑOR QUESUS",
        hora: "Todo el día",
      ));
      calendarElements =
          _calendarBox.get("calendar", defaultValue: calendarElements);

      yield CalendarLoadedState(eventos: calendarElements);
    }
  }
}