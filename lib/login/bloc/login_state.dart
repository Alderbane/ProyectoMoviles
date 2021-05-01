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

class AlreadyLoggedState extends LoginState {
  @override
  List<Object> get props => [];
}

class NotLoggedState extends LoginState {
  @override
  List<Object> get props => [];
}
