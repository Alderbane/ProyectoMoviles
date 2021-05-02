part of 'tareasclases_bloc.dart';

abstract class TareasclasesState extends Equatable {
  const TareasclasesState();

  @override
  List<Object> get props => [];
}

class TareasclasesInitial extends TareasclasesState {}

class LoadAllState extends TareasclasesState {
  final List eventos;

  LoadAllState({@required this.eventos});
  @override
  List<Object> get props => [eventos];
}
