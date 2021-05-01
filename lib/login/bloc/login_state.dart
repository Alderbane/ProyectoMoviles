part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginErrorState extends LoginState {
  final String error;
  final String code;

  LoginErrorState({@required this.error, this.code = "to be defined code"});

  @override
  List<Object> get props => [error, code];
}

class AlreadyLoggedState extends LoginState {
  @override
  List<Object> get props => [];
}

class NotLoggedState extends LoginState {
  @override
  List<Object> get props => [];
}

class SignoutSuccessState extends LoginState {
  @override
  List<Object> get props => [];
}
