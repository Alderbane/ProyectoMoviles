import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendario/models/event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  static final CalendarBloc _booksRepository = CalendarBloc._internal();

  factory CalendarBloc() {
    return _booksRepository;
  }
  // CalendarBloc(){};
  CalendarBloc._internal() : super(CalendarInitial());
  var _calendarDB = FirebaseFirestore.instance;
  var _id = FirebaseAuth.instance.currentUser.uid;
  Box _calendarBox = Hive.box("CalendarEvents");
  // CalendarBloc()  : super(CalendarInitial());

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is SaveEvent) {
      var calendarElements = [];
      var id = _calendarBox.get("id", defaultValue: 0);
      var a =
          _calendarDB.collection('eventos').doc(_id).collection("Mis eventos");
      await a.add(Evento(
              fecha: DateTime.now(),
              titulo: "Test feo",
              descripcion: "magia firebase",
              hora: "Todo el día")
          .toMap());
      calendarElements = _calendarBox.get("calendar", defaultValue: []);
      event.evento.id = id;
      calendarElements.add(event.evento);
      await _calendarBox.put("calendar", calendarElements);
      await _calendarBox.put("id", _calendarBox.get("id", defaultValue: 0) + 1);
      yield CalendarLoadedState(eventos: calendarElements);
    } else if (event is LoadEvent) {
      List calendarElements = [];
      calendarElements =
          _calendarBox.get("calendar", defaultValue: calendarElements);
      yield CalendarLoadedState(eventos: calendarElements);
    } else if (event is EditEvent) {
      yield CalendarEditState();
    } else if (event is UpdateEvent) {
      var calendarElements = [];
      calendarElements = _calendarBox.get("calendar");
      int i = calendarElements
          .indexWhere((element) => element.id == event.evento.id);
      calendarElements[i] = event.evento;
      await _calendarBox.put("calendar", calendarElements);
      yield CalendarLoadedState(eventos: calendarElements);
    }
  } //
}
