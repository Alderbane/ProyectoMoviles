import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:calendario/models/event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  // static final CalendarBloc _booksRepository = CalendarBloc._internal();

  // factory CalendarBloc() {
  //   return _booksRepository;
  // }
  // // CalendarBloc(){};
  // CalendarBloc._internal() : super(CalendarInitial());

  var _calendarDB = FirebaseFirestore.instance;

  var _id = (FirebaseAuth.instance.currentUser != null)
      ? FirebaseAuth.instance.currentUser.uid
      : "nouid";
  Box _calendarBox = Hive.box("CalendarEvents");
  // int _eventId = 0;
  CalendarBloc() : super(CalendarInitial());

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is SaveEvent) {
      yield CalendarLoadingState();
      var calendarElements = [];
      var myDoc = _calendarDB.collection('usuarios').doc(
          _id); //Conseguimos documento relacionado con en usuario actualpaint
      var id;
      await myDoc.get().then((DocumentSnapshot documentSnapshot) {
        //tomamos documento que mantiene el id
        id = 0;
        if (documentSnapshot.exists) {
          if (documentSnapshot.data()['currentId'] != null)
            id = documentSnapshot.data()['currentId'];
        }
      });
      print(id);
      await myDoc.set(
          {"currentId": id + 1}, SetOptions(merge: true)); //Se actualiza el id

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
      var misEventos =
          _calendarDB.collection('usuarios').doc(_id).collection('Mis eventos');
      var eventosFire =
          await misEventos.where('id', isEqualTo: event.evento.id).get();
      await misEventos
          .doc(eventosFire.docs[0].id)
          .set(event.evento.toMap(), SetOptions(merge: true));

      calendarElements = _calendarBox.get("calendar");
      int i = calendarElements
          .indexWhere((element) => element.id == event.evento.id);
      calendarElements[i] = event.evento;
      await _calendarBox.put("calendar", calendarElements);
      yield CalendarLoadedState(eventos: calendarElements);
    } else if (event is DownloadEvent) {
      var token = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(_id)
          .get()
          .then(
        (DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            return documentSnapshot.data()["token"];
          }
        },
      );
      var today = DateTime.now();
      today = DateTime(today.year, today.month, today.day);
      var tareasCollection = FirebaseFirestore.instance.collection("tareas");
      var myUserDoc = await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(_id)
          .get();
      List<dynamic> clasesIds = myUserDoc.data()["clases"] ?? [];
      for (var item in clasesIds) {
        var tareasOfItem =
            await tareasCollection.where("claseid", isEqualTo: item).get();
        for (var tarea in tareasOfItem.docs) {
          var element = tarea.data();
          var temp = DateTime.fromMicrosecondsSinceEpoch(
              element['fecha'].microsecondsSinceEpoch);
          element['fecha'] = DateTime(temp.year, temp.month, temp.day);

          if (today.compareTo(element["fecha"]) == 0) {
            print(element["fecha"]);
            List horaList = element["hora"].split(":");
            _sendMessage(token, '${element["nombre"]}',
                "${new DateFormat.yMMMMEEEEd('es').format(element["fecha"])} en ${horaList[0]}:${(int.parse(horaList[1]) < 10 ? '0' : '')}${horaList[1]}");
          }
        }
      }
      // original code
      var allEvents = await _calendarDB
          .collection('usuarios')
          .doc(_id)
          .collection("Mis eventos")
          .get();
      List calendarElements = [];
      allEvents.docs.forEach((element) {
        calendarElements.add(Evento.fromMap(element.data()));
        // if(6_eventId < element.data()[])
      });
      await _calendarBox.put("calendar", calendarElements);
      yield CalendarLoadedState(eventos: calendarElements);
    } else if (event is DeleteEvent) {
      yield CalendarLoadingState();
      var calendarElements = [];
      var misEventos =
          _calendarDB.collection('usuarios').doc(_id).collection('Mis eventos');
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

  void _sendMessage(String destination, String title, String body) {
    print("-------------------Enviando mensaje");
    var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "key=AAAAPcBRBrE:APA91bFh_ChbFE-a1Y82N3dVrClrMWuIk_zwT972kWIzzmA5Kf9TRFnja-8GeOHv5yMvbPfMzzKNLlRmqape4Z6XjhPa8UaFKMy_Ws8BAelZciPz9IEipt-hmzOpSYtq5vm_n_3v1UEw",
      },
      body: jsonEncode({
        "to": destination,
        "notification": {
          "title": title,
          "body": body,
        }
      }),
    );
  }
}
