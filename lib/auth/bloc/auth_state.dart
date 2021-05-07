part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AlreadyAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class UnAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class GoToClasesState extends AuthState {
  @override
  List<Object> get props => [];
}
class GoToCalificacionesState extends AuthState {
  @override
  List<Object> get props => [];
}
class GoToCalendarioState extends AuthState {
  @override
  List<Object> get props => [];
}