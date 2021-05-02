import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      var myUserDoc = await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(_auth.currentUser.uid)
          .get();
      var clasesCollection = FirebaseFirestore.instance.collection("clases");
      var tareasCollection = FirebaseFirestore.instance.collection("tareas");
      Map<DateTime, List<dynamic>> events;
      List<String> clasesIds = myUserDoc.data()["clases"];
      List<Map<String, dynamic>> clases;
      List<Map<String, dynamic>> tareas;
      var placeholder = groupBy(tareas, (tarea) => tarea["fecha"]);
      Map<DateTime, dynamic> mp;
      clasesIds.forEach((element) async {
        var doc = await clasesCollection.doc(element).get();
        clases.add(doc.data());
        var query =
            await tareasCollection.where("claseId", isEqualTo: element).get();
        query.docs.forEach((element) {
          tareas.add(element.data());
        });
      });
      clases.forEach((clase) {
        clase["dias"].forEach((weekday) {});
      });
    }
  }

  Map<DateTime, dynamic> createByPeriodYear(
      int year, int period, int weekday, Map<String, dynamic> object) {
    //semanas 16
    DateTime initial;
    Map<DateTime, dynamic> map;
    if (period == Periodo.primavera) {
      //inicio : 15 enero
      initial = DateTime(year, 1, 15);
    } else if (period == Periodo.otonio) {
      //inicio: 13 agosto
      initial = DateTime(year, DateTime.august, 15);
    }

    if (initial.weekday >= 4) {
      initial = initial.add(Duration(days: 8 - initial.weekday));
    } else {
      initial = initial.subtract(Duration(days: initial.weekday - 1));
    }

    initial = initial.add(Duration(days: weekday - 1));

    for (var i = 0; i < 16; i++) {
      map[initial.add(Duration(days: 7 * i))] = object;
    }
    return map;
  }
}
