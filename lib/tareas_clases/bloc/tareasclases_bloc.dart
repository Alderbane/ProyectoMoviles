import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

part 'tareasclases_event.dart';
part 'tareasclases_state.dart';

enum Periodo { primavera, otonio }

class TareasclasesBloc extends Bloc<TareasclasesEvent, TareasclasesState> {
  TareasclasesBloc() : super(TareasclasesInitial());
  var _auth = FirebaseAuth.instance;

  Stream<TareasclasesState> mapEventToState(
    TareasclasesEvent event,
  ) async* {
    if (event is GetAllEvent) {
      yield LoadingAllState();
      var today = DateTime.now();
      var token = await FirebaseFirestore.instance.collection('usuarios').doc(_auth.currentUser.uid).get().then( 
        (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return documentSnapshot.data()["token"];
        }else{
        
        }
        }
      );
      today = DateTime(today.year,today.month,today.day);
      var myUserDoc = await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(_auth.currentUser.uid)
          .get();
      var clasesCollection = FirebaseFirestore.instance.collection("clases");
      var tareasCollection = FirebaseFirestore.instance.collection("tareas");
      Map<DateTime, List<dynamic>> events = {};
      List<dynamic> clasesIds = myUserDoc.data()["clases"];
      List<Map<String, dynamic>> clases = [];
      List<Map<String, dynamic>> tareas = [];

      for (var element in clasesIds) {
        var doc = await clasesCollection.doc(element).get();
        clases.add(doc.data());
        var query =
            await tareasCollection.where("claseid", isEqualTo: element).get();
        query.docs.forEach((element) {
          var temp = element.data();
          temp["clase"] = doc.data()["nombre"];
          tareas.add(temp);
        });
      }

      // clasesIds.forEach((element) async {
      //   var doc = await clasesCollection.doc(element).get();
      //   clases.add(doc.data());
      //   var query =
      //       await tareasCollection.where("claseid", isEqualTo: element).get();
      //   print("a");
      //   query.docs.forEach((element) {
      //     tareas.add(element.data());
      //   });
      // });
      clases.forEach((clase) {
        clase["dias"].forEach((weekday) {
          var temp =
              createByPeriodYear(clase["año"], clase["tipo"], weekday, clase);
          temp.forEach((key, value) {
            if (events.containsKey(key)) {
              events[key].add(value);
            } else {
              events[key] = [value];
            }
          });
        });
      });
      tareas.forEach((element) {
        var temp = DateTime.fromMicrosecondsSinceEpoch(
            element['fecha'].microsecondsSinceEpoch);
        print("------------Temp-------------");
        print(temp);
        element['fecha'] = DateTime(temp.year, temp.month, temp.day);

        if(today.compareTo(element["fecha"]) == 0){
           List horaList = element["hora"].split(":");
          _sendMessage(token,'${element["nombre"]}',"${new DateFormat.yMMMMEEEEd('es').format(element["fecha"])} en ${horaList[0]}:${(int.parse(horaList[1]) < 10 ? '0' : '')}${horaList[1]}");
        }

        if (events.containsKey(element['fecha'])) {
          events[element['fecha']].add(element);
        } else {
          events[element['fecha']] = [element];
        }
      });
      yield (LoadAllState(eventos: events));
    }
  }

  Map<DateTime, dynamic> createByPeriodYear(
      int year, int period, int weekday, Map<String, dynamic> object) {
    //semanas 16
    DateTime initial;
    Map<DateTime, dynamic> map = {};
    if (period == 0) {
      //inicio : 15 enero
      initial = DateTime(year, DateTime.january, 15);
    } else if (period == 1) {
      //inicio: 13 agosto
      initial = DateTime(year, DateTime.august, 13);
    }
    print(initial);
    if (initial.weekday >= 4) {
      initial = initial.add(Duration(days: 8 - initial.weekday));
    } else {
      initial = initial.subtract(Duration(days: initial.weekday - 1));
    }

    initial = initial.add(Duration(days: weekday - 1));

    for (var i = 0; i < 16; i++) {
      var temp = initial.add(Duration(days: 7 * i));
      map[DateTime(temp.year, temp.month, temp.day)] = object;
    }
    return map;
  }

  void _sendMessage(String destination, String title, String body) {
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
