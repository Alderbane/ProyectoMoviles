part of 'calificaciones_bloc.dart';

abstract class CalificacionesState extends Equatable {
  const CalificacionesState();

  @override
  List<Object> get props => [];
}

class CalificacionesInitial extends CalificacionesState {}

class CalificacionesLoadedState extends CalificacionesState {
  final List<Map<String, dynamic>> calificaciones;

  CalificacionesLoadedState({@required this.calificaciones});

  @override
  List<Object> get props => [calificaciones];
}
