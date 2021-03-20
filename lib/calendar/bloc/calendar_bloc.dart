import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendario/models/event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial());

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
