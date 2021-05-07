part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VerifyAuthenticationEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignOutAuthenticationEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignInAuthenticationEvent extends AuthEvent {
  final String user;
  final String password;

  SignInAuthenticationEvent({@required this.user,@required this.password});
  @override
  List<Object> get props => [user,password];
}

class GoToClasesEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
class GoToCalificacionesEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
class GoToCalendarioEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignUpAuthenticationEvent extends AuthEvent {
  final String user;
  final String password;
  final String nombre;
  SignUpAuthenticationEvent({@required this.user,@required this.password, @required this.nombre});
  @override
  List<Object> get props => [user,password, nombre];
}
