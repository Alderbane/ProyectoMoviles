import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'tareasclases_event.dart';
part 'tareasclases_state.dart';

class TareasclasesBloc extends Bloc<TareasclasesEvent, TareasclasesState> {
  TareasclasesBloc() : super(TareasclasesInitial());

  @override
  Stream<TareasclasesState> mapEventToState(
    TareasclasesEvent event,
  ) async* {
    if (event is GetAllEvent) {}
  }
}
