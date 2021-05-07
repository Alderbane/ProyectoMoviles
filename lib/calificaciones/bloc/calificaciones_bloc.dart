import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'calificaciones_event.dart';
part 'calificaciones_state.dart';

class CalificacionesBloc
    extends Bloc<CalificacionesEvent, CalificacionesState> {
  CalificacionesBloc() : super(CalificacionesInitial());
  var _auth = FirebaseAuth.instance;
  @override
  Stream<CalificacionesState> mapEventToState(
    CalificacionesEvent event,
  ) async* {
    if (event is CalificacionesDownloadEvent) {
      var clasesCollection = FirebaseFirestore.instance.collection("clases");
      var myUserDoc = await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(_auth.currentUser.uid)
          .get();
      List<dynamic> clasesIds = myUserDoc.data()["clases"];
      List<Map<String, dynamic>> calificaciones = [];

      for (var element in clasesIds) {
        var doc = await clasesCollection.doc(element).get();
        Map<String, dynamic> calificacion = {};
        calificacion["nombre"] = doc.data()["nombre"];
        calificacion["calificacion"] =
            doc.data()["calificaciones"][_auth.currentUser.uid];

        calificaciones.add(calificacion);
      }
      print(calificaciones);
      yield (CalificacionesLoadedState(calificaciones: calificaciones));
    }
  }
}
