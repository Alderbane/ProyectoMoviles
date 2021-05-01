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
  // int _eventId = 0;
  // CalendarBloc()  : super(CalendarInitial());

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is SaveEvent) {
      var calendarElements = [];
      var myDoc = _calendarDB.collection('eventos').doc(
          _id); //Conseguimos documento relacionado con en usuario actualpaint
      var id;
      await myDoc.get().then((DocumentSnapshot documentSnapshot) {
        //tomamos documento que mantiene el id
        if (documentSnapshot.exists) {
          print("existe");
          if (documentSnapshot.data()['currentId'] != null)
            id = documentSnapshot.data()['currentId'];
          else
            id = 0;
        } else
          id = 0;
      });
      print(id);
      await myDoc.set({"currentId": id + 1}); //Se actualiza el id

      calendarElements = _calendarBox.get("calendar",
          defaultValue: []); //Traemos todos los datos almacenados en hive

      event.evento.id = id; //Asignamos id al evento
      calendarElements.add(event.evento); //Agregamos evento actual a hive
      await myDoc
          .collection("Mis eventos")
          .add(event.evento.toMap()); //Guardamos
      await _calendarBox.put("calendar", calendarElements);
      // await _calendarBox.put("id", _calendarBox.get("id", defaultValue: 0) + 1);
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
      var misEventos = await _calendarDB
          .collection('eventos')
          .doc(_id)
          .collection('Mis eventos');
      var eventosFire =
          await misEventos.where('id', isEqualTo: event.evento.id).get();
      await misEventos.doc(eventosFire.docs[0].id).update(event.evento.toMap());

      calendarElements = _calendarBox.get("calendar");
      int i = calendarElements
          .indexWhere((element) => element.id == event.evento.id);
      calendarElements[i] = event.evento;
      await _calendarBox.put("calendar", calendarElements);
      yield CalendarLoadedState(eventos: calendarElements);
    } else if (event is DownloadEvent) {
      var allEvents = await _calendarDB
          .collection('eventos')
          .doc(_id)
          .collection("Mis eventos")
          .get();
      List calendarElements = [];
      allEvents.docs.forEach((element) {
        calendarElements.add(Evento.fromMap(element.data()));
        // if(6_eventId < element.data()[])
      });
      await _calendarBox.put("calendar", calendarElements);
    } else if (event is DeleteEvent) {
      var calendarElements = [];
      var misEventos = await _calendarDB
          .collection('eventos')
          .doc(_id)
          .collection('Mis eventos');
      var eventosFire =
          await misEventos.where('id', isEqualTo: event.evento.id).get();
      await misEventos.doc(eventosFire.docs[0].id).delete();

      calendarElements = _calendarBox.get("calendar");
      int i = calendarElements
          .indexWhere((element) => element.id == event.evento.id);
      calendarElements.removeAt(i);
      await _calendarBox.put("calendar", calendarElements);
      yield CalendarLoadedState(eventos: calendarElements);
    }
  } //
}
